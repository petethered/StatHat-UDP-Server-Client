package Stathat;

# Sends updates to Stathat UDP server

use strict;
use warnings;
use IO::Socket ();

our $Stathat_HOST = 'localhost';
our $Stathat_PORT = 12321;
our $Stathat_EMAIL = 'demo@stathat.com';

sub send {
	my $data = join("|",@_);

    my $udp_sock = IO::Socket::INET->new(
        Proto    => 'udp',
       	PeerAddr => $Stathat_HOST,
        PeerPort => $Stathat_PORT,
    ) or return;


    $udp_sock->send($data);

    return 1;
}

sub increment {
	my ($key) = @_;
	return if !$key;
	
	Stathat::send($Stathat_EMAIL,$key,1);
}

sub value {
	my ($key,$value) = @_;
	return if !$key;
	
	Stathat::send($Stathat_EMAIL,$key,0,$value);
}

1;
