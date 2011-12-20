#!/usr/bin/perl
use strict;
use IO::Socket::INET;
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;


my $port = '12398';


my ($socket,$incomingdata);
my ($peeraddress,$peerport);

$| = 1;
$socket = new IO::Socket::INET (LocalPort => $port,Proto => 'udp') or die "ERROR in Socket Creation : $!\n";

while(1) {
	$socket->recv($incomingdata,1024);

#	print "\n said : $incomingdata\n";
	
	my ($email,$stat,$count,$value) = split(/\|/,$incomingdata);
	
	if ($email && $stat && $count) { 
		&stathat_ez_count($email,$stat,$count);
	} else {
		&stathat_ez_value($email,$stat,$value);
	}


}

$socket->close();



# Following  code used from stathat.pl provided by stathat.com

sub stathat_post {
        my ($path, $params) = @_;
        my $ua = LWP::UserAgent->new;
        my $req = POST 'http://api.stathat.com/' . $path, $params;
        return $ua->request($req)->as_string;
};


sub stathat_ez_count {
        my ($email, $stat_name, $count) = @_;
        return stathat_post('ez', [ email => $email, stat => $stat_name, count => $count ]);
};

sub stathat_ez_value {
        my ($email, $stat_name, $value) = @_;
        return stathat_post('ez', [ email => $email, stat => $stat_name, value => $value ]);
};

