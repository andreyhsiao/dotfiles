#!/usr/bin/perl

# Author: Andrey Hsiao (@andreyhsiao)
# Usage: pmset -g batt | ./battery-osx.pl

use strict;
use utf8;
use warnings;

my $symbol_battery = "🔋";
my $symbol_acpower = "⚡";

my $output1 = <STDIN>;
my $output2 = <STDIN>;
chomp $output1;
chomp $output2;

my $acpower_or_battery = "(unknown)";
if ($output1 =~ m/drawing\s+from\s+['"]?(\w+)/i) {
  if ($1 eq "AC") {
    $acpower_or_battery = $symbol_acpower;
  }
  if ($1 eq "Battery") {
    $acpower_or_battery = $symbol_battery;
  }
}

my $percentage = "";
my $remaining = "";
if ($output2 =~ m/InternalBattery.+?\s+(\d+%);\s+(.+?);\s+(.+?)\s*\Z/i) {
  $percentage = $1;

  if ($2 eq "discharging") {
    $remaining = $3;
  }
  else {
    $remaining = $2;
  }
}

binmode(STDOUT, ":utf8");
print STDOUT "$acpower_or_battery [$percentage] $remaining\n";

