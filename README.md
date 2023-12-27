# Archived

This repo has been archived and set to read only.
The license has been changed to Public Domain (unlicense).
This repo can be used as an example for other people's projects.

# weather.pl

A simple weather CGI script in Perl

## Getting Started

In order to run this program you'll need a few Perl libraries:

- CGI
- JSON
- LWP::UserAgent

To run this script for Nginx you will need to have `fcgiwrap` (or an
equilivent) and add this to your individual website config:

```
location /weather {
	gzip off;
	include fastcgi_params;
	fastcgi_param SCRIPT_FILENAME /path/to/script/weather.pl;
	fastcgi_param QUERY_STRING $query_string;
	fastcgi_pass unix:/run/fcgiwrap.socket;
}
```

## Note

This script is currently hardcoded to fetch weather in Grand Rapids, Michigan.
I will eventually change this to be dynamic.
