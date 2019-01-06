#!/usr/bin/perl

use strict;
use warnings;

use Scalar::Util qw(looks_like_number);

my $srv = $ENV{'PXFLUT_SRV'} || '127.0.0.1';
my $port = $ENV{'PXFLUT_PORT'} || '1000';
my $picdir = $ENV{'PXFLUT_DIR'} || '/var/sturmflut_docker/media-in';
my $debug = $ENV{'PXFLUT_DEBUG'} || 1;
my $timeout = $ENV{'PXFLUT_TIMEOUT'} || 60;
my $refresh = $ENV{'PXFLUT_REFRESH'} || 250;
my $x_off_user = $ENV{'PXFLUT_X'} || 'rand';
my $y_off_user = $ENV{'PXFLUT_Y'} || 'rand';

my $command = "timeout $timeout /var/sturmflut/sturmflut -p $port $srv";

sub get_size
{
	my $size = `echo "SIZE" | netcat -w 1 $srv $port`;

	my $x;
	my $y;

	if($size =~ /SIZE (\d+) (\d+)/)
	{
		$x = $1;
		$y = $2;

		print "\nWorking with width = $x, height = $y\n" if $debug == 1;

		return ($x, $y);
	}
	else
	{
		print "\nCannot read screen-size from Pixelflut-Server.\n";
		return (undef, undef);
	}
}

sub get_random_offset
{
	my $x = $1;
	my $y = $2;

	return int(rand($x)), int(rand($y));
}

sub get_picture_files
{
	my @files;
	opendir(DIR, $picdir);

	if($!)
	{
		print "\nCannot read files from directory.\n";
		return (undef);
	}

	@files = readdir(DIR);
	closedir(DIR);

	my @pictures;

	foreach(@files)
	{
		push @pictures, $_ if($_ =~ /^.+(?:jpg|jpeg|gif|png)$/);
	}

	if (scalar @pictures == 0)
	{
		print "\nThere are no pictures in directory.\n";
		return (undef);
	}

	return @pictures;
}

# main-program

my $x;
my $y;

my @pictures;

my $x_off;
my $y_off;

my $i = 0;

while(1)
{
	if($i == 0 || $i % $refresh == 0)
	{
		($x, $y) = &get_size;

		exit 1 if(!defined $x);

		@pictures = &get_picture_files;

		exit 1 if(!defined $pictures[0]);

		$i = 1;
	}

	if(looks_like_number($x_off_user) && $x_off_user <= $x && $x_off_user >= 0)
	{
		$x_off = $x_off_user
	}
	else
	{
		$x_off = int(rand($x));
	}

	if(looks_like_number($y_off_user) && $y_off_user <= $y && $y_off_user >= 0)
	{
		$y_off = $y_off_user
	}
	else
	{
		$y_off = int(rand($x));
	}

	my $this_picture = $pictures[int(rand(scalar @pictures))];

	# call sturmflut
	`$command $picdir/"$this_picture" -o $x_off:$y_off`;

	$i++;
}
