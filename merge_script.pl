#!/usr/bin/perl
use strict;
use warnings;

my $filename="commands.txt";
my $line;
my $output;
my $inFile;
my $srcDir;
my $newRoot;
my $ans;

open($inFile, "<", $filename)
  or die "Cannot open $filename: $!\n";

print "Enter top directory of BoilerBuntu files: ";
$srcDir = <STDIN>;

print "Enter root of BoilerBuntu filesystem: ";
$newRoot = <STDIN>;


chomp($srcDir);
if($srcDir =~ /^.+\/$/)#remove a trailing /
{
  chop($srcDir);
}

chomp($newRoot);
if($newRoot =~ /^.+\/$/)#remove a trailing /
{
  chop($newRoot);
}


print "\nThe source directory is $srcDir and the new root directory is $newRoot\n";
print "Is this correct? (Y/n) ";
$ans=<STDIN>;

chomp($ans);
if(!($ans eq "Y" or $ans eq "y"))
{
  close($inFile);
  exit;
}

while($line = <$inFile>)
{
  chomp($line);
  if(!(substr($line, 0, 1) eq "\#") and $line ne "")#check if line is comment
  {
    $line =~ s/\"SRCDIR\"/$srcDir/g;
    $line =~ s/\"NEWROOT\"/$newRoot/g;

    print "Executing $line\n";
    system($line);
    $output=`$line`;
    if($?==-1)
    {
      print "Error exicuting $line\n";
      print "$!\n";
      close($inFile);
      exit;
    }
  }
}

close($inFile);
