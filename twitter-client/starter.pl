#!/usr/bin/perl

use strict;
use warnings;
use String::Random;
use Net::Twitter::Lite::WithAPIv1_1;

my $consumer_key =  $ENV{'TWITTER_CONSUMER_KEY'} || undef;
my $consumer_secret = $ENV{'TWITTER_CONSUMER_SECRET'} || undef;
my $access_token = $ENV{'TWITTER_ACCESS_TOKEN'} || undef;
my $access_token_secret = $ENV{'TWITTER_ACCESS_TOKEN_SECRET'} || undef;
my $twitter_text = $ENV{'TWITTER_TEXT'} || 'automated #pixelflut image';

if(!defined $consumer_key || !defined $consumer_secret || !defined $access_token || !defined $access_token_secret)
{
	warn "Please specify all necessary credentials for twitter-authentication\n";
	exit 1;
}

my $string_gen = String::Random->new;
my $pic_name = $string_gen->randregex('\d\d\d\d\d\d\d\d\d\d\d\d');

$pic_name = $pic_name.'.png';

`cd /tmp && scrot $pic_name`;

if($?)
{
	warn "Error taking screenshot.";
	exit 1;
}

my $nt = Net::Twitter::Lite::WithAPIv1_1->new(
        consumer_key		=> $consumer_key,
        consumer_secret		=> $consumer_secret,
        access_token		=> $access_token,
        access_token_secret	=> $access_token_secret,
);

my @media = ('/tmp/'.$pic_name);

eval{$nt->update_with_media($twitter_text, \@media)};

if($@)
{
	warn "Could not send this tweet: $@\n";
	exit 1;
}

print "Tweet sent successfully.\n";

exit 0;
