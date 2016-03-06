package BetaSeries;

use strict;
use warnings;

use BetaSeries::Config;

use lib '../lib';

use Exporter;
use vars qw($NAME $SHORTNAME $VERSION @ISA @EXPORT @EXPORT_OK @EXPORT_TAGS);

use Data::Dumper;
use Messages;
use LWP;
use HTTP::Headers;

$NAME			= 'BetaSeries Librairie';
$SHORTNAME		= 'BSLib';
$VERSION 		= '2.00';
@ISA			= qw(Exporter);
@EXPORT 		= ();
@EXPORT_OK		= qw($VERSION);
@EXPORT_TAGS	= ();

sub new {
	my ($class) = @_;
	my $this = {};
	$class = ref($this) || $this;

	bless $this, $class;

	$this = {
		"CONFIG" 	=> {},
		"_UA" 		=> {},
		"_REQ"		=> {},
		"_TOKEN"	=> {},
		"_HEADERS"	=> {}
	};

	$this->{CONFIG} 	= BetaSeries::Config->new();
	$this->{_HEADERS} 	= HTTP::Headers->new();
	$this->{_UA} 		= LWP::UserAgent->new();

	return $this;
}

sub defaultHeaders {
	my ($this) = @_;
	my $h = &$this->{_HEADERS};

	 $h = HTTP::Headers->new(
       Date         => 'Thu, 03 Feb 1994 00:00:00 GMT',
       Content_Type => 'text/html; version=3.2',
       Content_Base => 'http://www.perl.org/'
    );

	 return 1;
}

sub newUserAgent {
	my ($this) = @_;

	# Create a user agent object
	my $ua = &$this->{_UA};
	$ua->agent("ADMedia/2.0 ");

	return 1;
}

sub newRequest {
	my ($this) = @_;

	my $ua = $this->{_UA};
	my $cnf = $this->{CONFIG};

	# Create a request
	my $req = HTTP::Request->new(POST => $cnf->{URL});
	$req->content_type('application/json');
	$req->content('query=libwww-perl&mode=dist');
	$this->{_REQ} = $req;

	# Pass request to the user agent and get a response back
	my $res = $ua->request($req);

	# Check the outcome of the response
	if ($res->is_success) {
			print $res->content;
	}
	else {
			print $res->status_line, "\n";
	}
}

1;
