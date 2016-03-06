package BetaSeries::Token;

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
		_token => undef,
		_authenticated => false,
		CONFIG => {}
	};

	bless $this, $class;

	$this->{CONFIG} = BetaSeries::Config->new();

	return $this;
}

sub get {
	my ($this) = @_;

	return $this->{_token}
}

sub set {
	my ($this, $token) = @_;

	$this->{_token} = $token;
}

1;
