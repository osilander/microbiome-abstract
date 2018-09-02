#!/usr/lib/perl5

use warnings;
use strict;

=head DESCRIPTION

makes up abstracts
AUG 13, 2016

=cut

if ( $ARGV[1] =~ /\d+/ ) {
	#do nothing
}
else {
	print "Second argument should be the number of words in the abstract.\n";
	exit;
}

print "organism: ", $ARGV[0], "\n";
print "Length of abstract: ", $ARGV[1], "\n";
my %words;
my @all_text;
my @replace = ("oyster", "human", "fish", "chicken", "esophageal", "male", "female", "vaginal", "animal", "dental", "Caucasian", "mother", "twin", "mouse", "soil", "rat", "stool", "yak", "heifer", "horse", "lung", "cattle", "plant", "esophagus", "cervical", "cancer", "infant", "feces", "borer", "Batwa", "carie", "mucosal", "HIV", "DM", "tooth", "murine", "eggshells", "nest", "ugt", "patient", "cat", "dog", "insect", "semen", "foal", "liver", "restroom", "room", "specimen", "primate", "bull", "caries", "pig", "animal", "sponge", "group", "women", "men", "loris", "control", "canine", "children", "adults", "zebrafish", "copepod", "mice", "Drosophila");

open INPUT, "./microbiome_plos_500.txt" || die "Cannot open input file: $!";
my $output = "abstract.txt";
#open OUTPUT , ">./$output" || die "Cannot open output file: $!";
while (<INPUT>) {
	my $text=$_;
	$text =~ s/\(\S+\)//g;
	$text =~ s/Summary//g;
	$text =~ s/Results//g;
	$text =~ s/Introduction//g;
	$text =~ s/Conclusion//g;
	$text =~ s/Objectives//g;
	$text =~ s/Background//g;
	$text =~ s/Objective//g;
	$text =~ s/Author//g;
	$text =~ s/Authors//g;
	$text =~ s/Methods//g;
	$text =~ s/Methodology//g;
	$text =~ s/Principle Findings//g;
	$text =~ s/,//g;
	my @text = split ' ', $text;
	push (@all_text, @text);
	#print $text[1], "\n";
	#print "words: ", scalar(@text), "\n";	
}

for my $i (0..(scalar(@all_text)-3)) {
	my $two_words = join(' ', $all_text[$i], $all_text[$i+1]);
	push @{ $words{$two_words} }, $all_text[$i+2];
}

my @key_words = keys %words;

my @paragraph;
my $current = "The microbiome";
my $count;
my $flag=1;
while($flag) {
	$count++;
	my $next = ${ $words{$current} }[int(rand(scalar(@{ $words{$current} })))-1];
	my @second = split(' ', $current);
	push @paragraph, $second[0];
	$current = join(' ', $second[1], $next);
	if($count>$ARGV[1] && $next =~ /\./) { $flag=0; push @paragraph, $second[1], $next; }
	#print "$next\n";
}
print "\n";
my $paragraph = join ' ', @paragraph;
my $replace_with = ' '.$ARGV[0].' ';
for (@replace) {
	$replace_with = ' '.$ARGV[0].' ';
	my $replace = ' '.$_.' ';
	$paragraph =~ s/$replace/$replace_with/g;
	
	$replace =~ s/(\s)$/s$1/;
	$replace_with =~ s/(\s)$/s$1/;
	$paragraph =~ s/$replace/$replace_with/g;
		
	$replace_with =~ s/(\s)$/\.$1/;
	$replace =~ s/(\s)$/.$1/;
	$paragraph =~ s/$replace/$replace_with/g;
}

$paragraph =~ tr/,/ /;
print "$paragraph\n\n";
exit;

