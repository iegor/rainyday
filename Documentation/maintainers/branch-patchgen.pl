#!/usr/bin/perl

use strict;
use warnings;

use SVN::Client;

my $branch = 'svn://anonsvn.kde.org/home/kde/branches/KDE/3.5';
my $tag = 'svn://anonsvn.kde.org/home/kde/tags/KDE/3.5.10';

sub svn_err {
  my $err = shift;
  my $str = $err->strerror();
  $str = '<no strerror>' unless defined $str;
  print STDERR "ERROR: $str\n";
  while ($err) {
    my $msg = $err->message();
    $msg = '<no message>' unless defined $msg;
    print STDERR "$msg\n";
    $err = $err->child();
  }
  exit 1;
}
$SVN::Error::handler = \&svn_err;

my $last_tag_rev;
sub tag_info_receiver {
  my ($path, $info) = @_;
  $last_tag_rev = $info->last_changed_rev();
}

my %tag_rev = ();
my $first_tag_rev;
sub tag_log_receiver {
  my ($changed_paths, $revision) = @_;
  for my $path (keys %$changed_paths) {
    my $lcp = $changed_paths->{$path};
    my $copyrev = $lcp->copyfrom_rev();
    next if $copyrev == $SVN::Core::INVALID_REVNUM;
    $path =~ s:^/tags/KDE/3\.5\.0/::;
    next if defined $tag_rev{$path};
    $tag_rev{$path} = $copyrev;
    $first_tag_rev = $revision;
    # print "$path copied from $revision\n";
  }
}

my %mod_rev = ();
sub branch_log_receiver {
  my ($changed_paths, $revision) = @_;
  for my $path (keys %$changed_paths) {
    my $lcp = $changed_paths->{$path};
    next if $path =~ m:/branches/KDE/3\.5/kde-common/:;
    if ($path =~ m:/branches/KDE/3\.5/(kdelibs|kdevelop)/:) {
      $mod_rev{$1} = $revision;
    }
    elsif ($path =~ m:/branches/KDE/3\.5/([^/]+/[^/]+)/:) {
      $mod_rev{$1} = $revision;
    }
    else {
      print "Skipping path $path\n";
    }
  }
}

my $mod;
sub mod_log_receiver {
  my ($changed_paths, $revision, $author, $date, $message) = @_;
  $author = '?' unless defined $author;
  my $msg = $message;
  $msg = '' unless defined $message;
  $msg =~ s/\r//g;
  $msg =~ s/\n\n.*//s;
  $msg =~ s/\s+$//;
  $msg =~ s/\s+/ /g;
  $msg =~ s/^(.{70,110})\. .*/$1. .../ if length($msg) > 120;
  $msg =~ s/^(.{70,115}) .*/$1.../ if length($msg) > 120;
  $msg =~ s/^(.{117}).*/$1.../ if length($msg) > 120;
  print PATCH "r$revision | $author\n$msg\n";
  for my $path (sort keys %$changed_paths) {
    my $lcp = $changed_paths->{$path};
    my $chg = $lcp->action();
    next unless $path =~ m:/branches/KDE/3\.5/\Q$mod\E/(.*):;
    print PATCH "  $chg $1\n";
  }
}

$| = 1;
my $svn = SVN::Client->new() || die;
my $pool1 = $svn->pool();
print "Finding tag info... ";
my $pool2 = SVN::Pool->new($pool1);
$svn->info($tag, undef, 'HEAD', \&tag_info_receiver, 0, $pool2);
print "tag last modified at r$last_tag_rev\n";
print "Examining tag log... ";
$svn->log($tag, 'HEAD', 0, 1, 1, \&tag_log_receiver, $pool2);
print "tag first created at r$first_tag_rev\n";
print "Examining branch changes since r$first_tag_rev...\n";
$svn->log($branch, $first_tag_rev, 'HEAD', 1, 1, \&branch_log_receiver, $pool2);
$pool2->clear();
print "Now generating individual patch files\n";
for (sort keys %mod_rev) {
  $mod = $_;
  my $tag_dir = $mod;
  my $tag_rev = $first_tag_rev;
  while ($tag_dir) {
    if (defined $tag_rev{$tag_dir}) {
      $tag_rev = $tag_rev{$tag_dir};
      last;
    }
    $tag_dir =~ s:/?[^/]+$::;
  }
  my $revision = $mod_rev{$mod};
  my $patchfile = "$mod-r$revision.patch";
  $patchfile =~ s:/:_:g;
  next if -e $patchfile;
  print "Creating $patchfile; logging since r$tag_rev\n";
  open PATCH, '+>', $patchfile or die "Error opening $patchfile";
  $svn->diff([], "$tag/$mod", $last_tag_rev, "$branch/$mod", $revision,
             1, 1, 0, \*PATCH, \*STDERR, $pool2);
  seek PATCH, 0, 0 or die "Failed to rewind $patchfile";
  $_ = join('', <PATCH>);
  s:^(---|\+\+\+) (.*?)\((\.\.\./[^/]+/KDE/[^/]+)/(.*?)\):$1 $4/$2 ($3):gm;
  my $patch = $_;
  seek PATCH, 0, 0 or die "Failed to rewind $patchfile";
  print PATCH "Changes between KDE 3.5.10 tag and KDE 3.5 branch r$revision.\n";
  print PATCH "Only looking at subdirectory $mod here.\n";
  print PATCH "Logs since r$tag_rev of the branch but this might be wrong.\n\n";
  $svn->log("$branch/$mod", $tag_rev, $revision, 1, 0,
            \&mod_log_receiver, $pool2);
  $pool2->clear();
  print PATCH "\n\n$patch";
  close PATCH or die "Error closing $patchfile";
}
