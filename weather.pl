#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use CGI;
use JSON;
use LWP::UserAgent;

my $weather_url = "https://api.weather.gov/points/";
my $default_weather = $weather_url . "42.8045,-85.6479";

binmode STDOUT, ":utf8";
my $ua = new LWP::UserAgent;
$ua->agent('PerlWeather');
$ua->timeout(120);

# Takes weather url and returns forecast url
sub get_forecast {
	my $request = new HTTP::Request('GET', $_[0]);
	my $response = $ua->request($request);
	my $data = decode_json $response->content();
	return $data->{'properties'}{'forecast'};
}

# Takes forecast url and returns array of periods
sub get_weather {
	my $request = new HTTP::Request('GET', $_[0]);
	my $response = $ua->request($request);
	my $data = decode_json $response->content();
	return $data->{'properties'}{'periods'};
}

my $cgi = CGI->new();

print $cgi->header( -type => 'text/plain', -charset => 'UTF-8');

print "Forecast in GRR\n\n";
my @periods = @{ get_weather(get_forecast($default_weather)) };
foreach my $t (@periods) {
	print $t->{'name'} . "\n";
	print "Temp: " . $t->{'temperature'} . "℉\n";
	print "Forecast: " . $t->{'shortForecast'} . "\n";
	print "----------\n";
}
