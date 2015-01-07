#!/usr/bin/env perl
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'             => 'Google::Tasks',
    'AUTHOR'           => 'Gryphon Shafer <gryphon@cpan.org>',
    'VERSION_FROM'     => 'lib/Google/Tasks.pm',
    'ABSTRACT_FROM'    => 'lib/Google/Tasks.pm',
    'PL_FILES'         => {},
    'MIN_PERL_VERSION' => '5.010',
    'PREREQ_PM'        => {
        'Moo'                   => 0,
        'namespace::clean'      => 0,
        'LWP::UserAgent'        => 0,
        'LWP::Protocol::https'  => 0,
        'HTML::Form'            => 0,
        'JSON'                  => 2,
        'HTTP::Request::Common' => 0,
        'Try::Tiny'             => 0,
        'List::MoreUtils'       => 0,
        'Carp'                  => 0,
        'Date::Parse'           => 0,
        'DateTime'              => 0,
        'Test::Most'            => 0,
    },
    'dist'  => { 'COMPRESS' => 'gzip -9f', 'SUFFIX' => 'gz' },
    'clean' => { 'FILES'    => 'Google-Tasks-*' },
    ( $ExtUtils::MakeMaker::VERSION >= 6.3002 ? ( 'LICENSE' => 'perl' ) : () ),
    ( eval { ExtUtils::MakeMaker->VERSION(6.46) } ? ( 'META_MERGE' => {
        'meta-spec' => { version => 2 },
        'resources' => {
            'repository' => {
                'type' => 'git',
                'url'  => 'https://github.com/gryphonshafer/Google-Tasks.git',
                'web'  => 'https://github.com/gryphonshafer/Google-Tasks',
            },
        } } ) : ()
    ),
);
