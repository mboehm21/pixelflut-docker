#!/usr/bin/perl

use strict;
use warnings;
use String::Random;

my $keyword = $ENV{'GRAB_KEYWORD'} || 'testbild';
my $picdir = $ENV{'GRAB_DIR'} || '/var/sturmflut_docker/media-in';
my $count = $ENV{'GRAB_COUNT'} || '10';
my $size = $ENV{'GRAB_SIZE'} || 'medium';
my $proxy = $ENV{'GRAB_PROXY'} || '""';
my $other = $ENV{'GRAB_MISC'} || '';
my $flush = $ENV{'GRAB_FLUSH'} || '1';
my $debug = $ENV{'GRAB_DEBUG'} || '1';

$count = 100 if($count > 100);

sub rename_picture_files
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

	foreach(@files)
	{
		if($_ =~ /^.+(jpg|jpeg|gif|png)$/)
		{
			my $string_gen = String::Random->new;
			my $new_name = $string_gen->randregex('\d\d\d\d\d\d\d\d\d\d\d\d');

			`cd $picdir && mv "$_" $new_name.$1`;
		}
	}

	return 1;
}

# main-program

my $command = "googleimagesdownload -k \"$keyword\" -l $count -n -o $picdir -s $size -px $proxy $other";

`cd $picdir && rm -f *` if($flush);

print "$command\n" if($debug);

`$command`;

&rename_picture_files();

exit 0;
