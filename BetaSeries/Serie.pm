package BetaSeries::Serie;

use strict;
use warnings;

use base "BetaSeries";
use BetaSeries::Config;
use Messages;

use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK @EXPORT_TAGS %CACHE);

use Data::Dumper;
use LWP;

sub new {
	my ($class) = @_;
	my $this = {
		_authenticated => 0,
		CONFIG => {},
		SHOW => {}
	};

	bless $this, $class;

	$this->{CONFIG} = BetaSeries::Config->new();

	return $this;
}

sub setURL {
	my ($this, $url) = @_;

	$this->{SURL} = $url;
}

sub search {
	my ($this, $title) = @_;

	my $req = $this->newRequest();

	$req->method("GET");
	$req->uri($this->{CONFIG}->getOpt('URL')."/shows/search.json?key=".
		$this->{CONFIG}->getOpt('BS_API_KEY')."&title=".$title);

	$this->execute($req);

	use JSON;
	my $return = from_json($this->{_content})->{root};

	if ($return->{code}) {
		$this->{SHOW} = $return->{shows}->{0};
		return 1;
	}

	return 0;
}

sub getDetails {
	my ($this) = @_;

	if (!$this->{SHOW}->{url}) {
		return 0;
	}

	my $req = $this->newRequest();

	$req->method("GET");
	$req->uri($this->{CONFIG}->getOpt('URL')."/shows/display/".
		$this->{SHOW}->{url}.".json?key=".$this->{CONFIG}->getOpt('BS_API_KEY'));

	$this->execute($req);

	use JSON;
	my $return = from_json($this->{_content})->{root};

	if ($return->{code}) {
		$this->{SHOW} = $return->{show};

		return 1;
	} else {
		print Dumper($req);
	}
	return 0;
}

1;
