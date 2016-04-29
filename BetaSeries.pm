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

	return $this;
}

sub newUserAgent {
	my ($this) = @_;

	# Create a user agent object
	my $ua = LWP::UserAgent->new();
	$ua->agent("ADMedia/2.0 ");
	$this->{_UA} = $ua;

	return 1;
}

sub newRequest {
	my ($this) = @_;

	$this->newUserAgent();

	# Create a request
	my $req = HTTP::Request->new(POST => $this->{CONFIG}->getOpt("URL"));
	$req->content_type('application/json');
	$req->content('query=libwww-perl&mode=dist');
	#$this->{_REQ} = $req;

	return $req;
}

sub execute {
	my ($this, $req) = @_;

	# Pass request to the user agent and get a response back
	my $res = $this->{_UA}->request($req);


	# Check the outcome of the response
	if ($res->is_success) {
		#print $res->content;
		$this->{_content} = $res->{_content};
		return 1;
	}
	else {
		$this->{_RES} = $res;
		print $res->status_line, "\n";
		return 0;
	}
}

1;
