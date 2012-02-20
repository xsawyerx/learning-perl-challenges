#!/usr/bin/perl
# challenge #1
# http://www.learning-perl.com/?p=270

use strict;
use warnings;

use Config;
use File::Spec;

my $usage = "$0 [-a] filename\n";

@ARGV > 2 and die "Hey, too many arguments!\n" . $usage;

my $separator = $Config{'path_sep'};
my @paths     = split /$separator/, $ENV{'PATH'};
my ( $all, $filename, @found );

# dead-simple ARGV parsing
foreach my $arg (@ARGV) {
    if ( $arg eq '-a' ) {
        $all++;
    } else {
        $filename = $arg;
    }
}

$filename or die "Hey, no filename given!\n" . $usage;
                 
foreach my $path (@paths) {
    my $file = File::Spec->catfile( $path, $filename );

    if ( -f $file ) {
        if ( ! $all ) {
            print "$file\n";
            exit 0;
        }

        push @found, $file;
    }
}

print join ( "\n", @found ), "\n";

