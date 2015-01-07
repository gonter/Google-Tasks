# Google::Tasks - Manipulate Google/GMail Tasks

This module is an attempt to provide a simple means to manipulate the "Tasks"
functionality provided by Google's GMail. For more information, see:

    https://mail.google.com/tasks

That being said, I didn't use a Google API for this module. Instead, it
basically scrapes JSON off Google. I found this to be far easier than using
Google's API. I never intended this to be a real module, just something that I
could use quickly/easily myself. I'm only publishing this in case someone else
might find it useful as-is. It's not well-tested and probably never will be.
And Google could break this entire library by changing their JSON structure.
Consequently, this module should probably not be used by anyone, ever.

[![Build Status](https://travis-ci.org/gryphonshafer/Google-Tasks.svg)](https://travis-ci.org/gryphonshafer/Google-Tasks)
[![Coverage Status](https://coveralls.io/repos/gryphonshafer/Google-Tasks/badge.png)](https://coveralls.io/r/gryphonshafer/Google-Tasks)

## Installation

To install this module, run the following commands:

    perl Makefile.PL
    make
    make test
    make install

## Support and Documentation

After installing, you can find documentation for this module with the
perldoc command.

    perldoc Google::Tasks

You can also look for information at:

- [GitHub](https://github.com/gryphonshafer/Google-Tasks "GitHub")
- [AnnoCPAN](http://annocpan.org/dist/Google-Tasks "AnnoCPAN")
- [CPAN Ratings](http://cpanratings.perl.org/m/Google-Tasks "CPAN Ratings")
- [Search CPAN](http://search.cpan.org/dist/Google-Tasks "Search CPAN")

## Author and License

Gryphon Shafer, [gryphon@cpan.org](mailto:gryphon@cpan.org "Email Gryphon Shafer")

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
