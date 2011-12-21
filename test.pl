#!/usr/bin/perl
use strict;

require "Stathat.pm";

# set these if need be
#
#$Stathat::Stathat_HOST = 'localhost';
#$Stathat::Stathat_PORT = 12321;
#$Stathat::Stathat_EMAIL = 'test@stathat.com';
#

# simple increment - used for count type items at Stathat
# &Stathat::increment('countername');

&Stathat::increment('This_Is_Test');

#  simple valueset - used for value type items at stathat
# &Stathat::value('countername',123);

&Stathat::value('Value_test',int(rand(100)));

