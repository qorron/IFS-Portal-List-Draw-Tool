#!/usr/bin/perl
use strict;
use warnings;
use 5.030;
use Data::Dumper;
use JSON;

# this very small perl script will (in an hour or so)
# convert the portal list document into a draw-tools
# datastructure which can be pasted into IITC
#
# Template:
# https://docs.google.com/document/d/1oh49z2-5CZFWRPleh06D7kamsWlYlQgtsE_DvUqu5iE/edit?usp=sharing
# to edit select: File -> make a copy

my $elements = [];
my $additional_elements = [];

my $i = 1;
my $first = 1;
my $first_color = '#a24ac3';
my $default_color = '#a24ac3';
my $color_gradient = {
	1 => '#57D600',
	2 => '#CFD200',
	3 => '#CE5900',
	4 => '#CA001D',
	5 => '#C60090',
	6 => '#8700C2',
	7 => '#1500BF',
};
my $color = $default_color;
my $colors = {
	letter  => '#3476d1',
	number  => '#43d921',
	keyword => '#d14a21',
};
my $current_polyline  = {};
my $symbol            = '';
my $state             = 'none';
my $state_transitions = {
	none   => 'first',
	first  => 'second',
	second => 'nth',
	nth    => 'nth',
};
my $segment = 0;
my @rest;
my $structure = '';

while (<>) {

	if (/^(\d+)(?:\W+(\w+)(.*))?$/) {
		my $t = lc($2) // '';
		$color  = exists $colors->{$t} ? $colors->{$t} : $default_color;
		$symbol = $1;
		my $rest = $3 // '';
		$rest =~ s/^\s+|\s+$//g;
		my $h = '#' x length $t;
		my $j = '#' x length $symbol;

		say "Structure: $structure";
		say '';
		say encode_json( [@$elements, @$additional_elements] ) if @$elements;
		$elements            = [];
		$additional_elements = [];
		$segment             = 0;
		$structure           = '';
		push @rest, $rest;

		print <<HEAD;


###########$j######$h####
### Symbol $symbol is a $t ###
###########$j######$h####
HEAD
		say $rest if $rest;
	}

	#pll=48.213582,16.391134
	if (/pll=(\d+(?:\.\d+)?),(\d+(?:\.\d+)?)/) {
		die "unknown state: $state" unless $state_transitions->{$state};
		$state = $state_transitions->{$state};
		my $point = { lat => $1, lng => $2 };

		if ( $state eq 'first' ) {
			$segment++;
			$structure .= '*';
			push @$elements,
				{
				color  => $color_gradient->{$segment} // $color,
				latLng => $point,
				type   => 'marker',
				};
			$first            = 0;
			$current_polyline = {    # init
				color   => $color,
				latLngs => [$point],
				type    => 'polyline'
			};
		}
		elsif ( $state eq 'second' ) {
			push @$elements, $current_polyline;
		}
		else {
		}
		if ( $state =~ m'nth|second' ) {
			push $current_polyline->{latLngs}->@*, $point;
			$structure .= '-';
			push @$additional_elements,
				{
				color  => '#bbbbbb',
				latLng => $point,
				type   => 'marker',
				};
		}
	}
	else {
		$structure .= '_' if /^\s+\d/;
		$state = 'none';
	}
	$i++;
}

# flush
say "Structure: $structure";
say '';
say encode_json($elements);
$elements = [];
say join "\n", "\n", 'Findings:', @rest;

