package BetaSeries::Config;

use strict;
use warnings;

use parent "BetaSeries";
use Tools::Config;

use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK @EXPORT_TAGS %CACHE);

use Data::Dumper;
use Messages;
use LWP;

my $CONFIG = {
	URL 		=> 'https://api.betaseries.com',
	BS_LOGIN 	=> 'Adadov',
	BS_API_KEY 	=> '19f9c937b4b8',
	hpass 		=> "72c71b7b985e27d9083ed4e7bc6601fb"
};

sub new {
	my ($class) = @_;
	my $this = {};

	bless $this, $class;

	$this->{CONFIG} = $CONFIG;

	#use Tools::Config qw($CONFIG);
	#$this->{CONFIG} = ($this->{CONFIG}, $CONFIG);

	return $this;
}

sub add {
	my ($this, $name, $value) = @_;

	$this->{CONFIG}->{$name} = $value;
}

sub del {
	my ($this, $name) = @_;

	delete $this->{CONFIG}->{$name};
}

sub getOpt {
	my ($this, $name) = @_;

	if ($this->{CONFIG}->{$name}) {
		return $this->{CONFIG}->{$name};
	}
	else {
		return "";
	}
}

1;
