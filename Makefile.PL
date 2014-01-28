
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "A Modern Perl Framework for High Throughput Sequencing analysis",
  "AUTHOR" => "Emmanouil \"Manolis\" Maragkakis <mns.marag\@gmail.com>, Panagiotis Alexiou <pan.alexiou\@gmail.com>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "GenOO",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "GenOO",
  "PREREQ_PM" => {
    "DBI" => 0,
    "DBIx::Class::Core" => 0,
    "DBIx::Class::Schema" => 0,
    "FileHandle" => 0,
    "Modern::Perl" => 0,
    "Moose" => 0,
    "Moose::Role" => 0,
    "Moose::Util::TypeConstraints" => 0,
    "MooseX::AbstractFactory" => 0,
    "MooseX::MarkAsMethods" => 0,
    "autodie" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0
  },
  "TEST_REQUIRES" => {
    "PerlIO::gzip" => 0,
    "Test::Class" => 0,
    "Test::Class::Load" => 0,
    "Test::Class::Moose" => 0,
    "Test::Class::Moose::Load" => 0,
    "Test::Class::Moose::Role::AutoUse" => 0,
    "Test::Exception" => 0,
    "Test::Moose" => 0,
    "Test::More" => 0,
    "Test::Most" => 0,
    "base" => 0
  },
  "VERSION" => "1.4.2",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "DBI" => 0,
  "DBIx::Class::Core" => 0,
  "DBIx::Class::Schema" => 0,
  "FileHandle" => 0,
  "Modern::Perl" => 0,
  "Moose" => 0,
  "Moose::Role" => 0,
  "Moose::Util::TypeConstraints" => 0,
  "MooseX::AbstractFactory" => 0,
  "MooseX::MarkAsMethods" => 0,
  "PerlIO::gzip" => 0,
  "Test::Class" => 0,
  "Test::Class::Load" => 0,
  "Test::Class::Moose" => 0,
  "Test::Class::Moose::Load" => 0,
  "Test::Class::Moose::Role::AutoUse" => 0,
  "Test::Exception" => 0,
  "Test::Moose" => 0,
  "Test::More" => 0,
  "Test::Most" => 0,
  "autodie" => 0,
  "base" => 0,
  "namespace::autoclean" => 0,
  "strict" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



