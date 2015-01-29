# NAME

Google::Tasks - Manipulate Google/GMail Tasks

# VERSION

version 1.02

# SYNOPSIS

    use Google::Tasks;

    my $google_tasks = Google::Tasks->new();
    $google_tasks->login( user => 'user', passwd => 'passwd' );

    my $gt = Google::Tasks->new( user => 'user', passwd => 'passwd' );

    my $list_object = $gt->lists->[0];
    my $active_list = $gt->active_list;

    $gt->refresh;                   # refresh the current list's data
    $gt->refresh('List Name');      # switch to a different list
    $gt->refresh( 'List Name', 1 );

    my $list = $gt->add_list('List Name');
    $gt->drop_list('List Name');

    my $list2 = $gt->rename_list( 'Current List Name', 'New List Name' );
    my $list3 = $gt->clear_list('List Name');

    $list->name('New List Name');
    $list->save;
    $list->drop;
    $list->clear;

    $gt->drop_task('Task Name');
    $gt->task_by_name('Task Name');

    my $task = $gt->add_task(
        name      => 'Task Name',
        notes     => 'Notes',
        completed => 0,             # defaults false
        deleted   => 0,             # defaults false
        task_date => DateTime->now, # defaults null
    );

    $task->move(2);
    $task->move('down');
    $task->move('up');
    $task->move( $gt->task_by_name('Other Task') );
    $task->move($list);

    $task->save;
    $task->drop;

# DESCRIPTION

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

# LIBRARY METHODS AND ATTRIBUTES

The following are methods and attributes of the core/parent library
(Google::Tasks) that pertain to core library functionality.

## new

This instantiator is provided by [Moo](https://metacpan.org/pod/Moo). It can optionally accept a username
and password, and if so provided, it will call `login()` automatically.

    my $gt  = Google::Tasks->new;
    my $gt2 = Google::Tasks->new( user => 'user', passwd => 'passwd' );

## login

This method accepts a username and password for a valid/current GMail account,
then attempts to authenticate the user and start up a session with Google Tasks.

    $gt->login( user => 'user', passwd => 'passwd' );

The method returns a reference to the object from which the call was made. And
please note that the authentication takes place via a simple [LWP::UserAgent](https://metacpan.org/pod/LWP::UserAgent)
scrape of a web form. For this to work, [LWP::Protocol::https](https://metacpan.org/pod/LWP::Protocol::https) must be
installed and SSL support must be available.

Following successful authentication, Google will return task lists data and
data for the tasks within the default/primary task list. This data gets parsed
into a series of attributes and sub-objects.

## lists

Following login, this attribute will contain a reference to a list of Google
Tasks lists (as objects). Specifically, these are Google::Tasks::List objects.
(See below.)

    my @all_lists   = @{ $gt->lists };
    my $list_object = $gt->lists->[0];

## tasks

Following login, this attribute will contain a reference to a list of Google
Tasks tasks (as objects). Specifically, these are Google::Tasks::Task objects.
(See below.) The tasks will only be from the current/active list, not all lists.
To switch lists, you'll need to `refresh()` to a different list.

    my @all_tasks  = @{ $gt->lists };
    my $first_task = $gt->lists->[0];

## active\_list

This is a reference to the current/active list (as an object). Specifically,
this is a Google::Tasks::List object. (See below.)

    my $active_list = $gt->active_list;

## refresh

Following a login, the tasks that get populated will only be from the
current/active list, not all lists. To switch lists, you'll need to `refresh()`
to a different list.

    $gt->refresh;             # refresh the current list's data
    $gt->refresh('List Name'); # switch to a different list

The method returns a reference to the object from which the call was made.

By default, the refresh call populates tasks that are not deleted. However,
in the spirit of never really deleting anything ever, Google doesn't delete
deleted tasks. So if you provide an optional second parameter to `refresh()`
that's boolean true, it will return tasks that are both deleted and undeleted.

    $gt->refresh( 'List Name', 1 );

# LIST LIBRARY METHODS

The following are methods of the core/parent library (Google::Tasks) that
pertain to list functionality. These are helper/wrapper methods around methods
provided by Google::Tasks::List. (See below.)

## add\_list

This method creates a list and returns an object representing the list. The
object is an instantiation of Google::Tasks::List. The only value to supply,
which is required, is a text string representing the new list's name

    my $list = $gt->add_list('List Name');

## drop\_list

This method deletes a list based on a name match.

    $gt->drop_list('List Name');

Note that it is entirely possible to have multiple lists with the same name.
In those cases, only the first list with matching name is deleted. This method
returns a reference to the object from which it was called.

## rename\_list

This method renames a list based on a name search.

    my $list = $gt->rename_list( 'Current List Name', 'New List Name' );

Note that it is entirely possible to have multiple lists with the same name.
In those cases, only the first list with matching name is renamed.

## clear\_list

This method issues a call to "clear" a list, which basically means that any
task items on the list that are set as completed will be deleted off the list.

    my $list = $gt->clear_list($list_name);

# LIST OBJECT METHODS

The following are methods of the list sub-library Google::Tasks::List.

## new

This instantiator requires a text string representing the name of the new list
and a required "root" parameter, which is an instantiated Google::Tasks object.

    my $list = Google::Tasks::List->new( name =>, 'List Name', root => $gt );

You probably don't want to ever use this method directly; instead, use the
`add_list()` method from Google::Tasks.

## name

This is a simple [Moo](https://metacpan.org/pod/Moo) get-er/set-er for the list's name. Changing the name
value itself won't really do anything useful until you envoke `save()`.

    $list->name('New List Name');

## save

This method saves changes made to the list metadata, which is really only the
list's name.

    $list->save;

The method returns a reference to the list.

## drop

This method deletes a list.

    $list->drop;

## clear

This method issues a call to "clear" a list, which basically means that any
task items on the list that are set as completed will be deleted off the list.

    $list->clear;

# TASK HELPER METHODS

The following are helper methods of the core/parent library (Google::Tasks)
that pertain to tasks.

## add\_task

This method instantiates a Google::Tasks::Task object and adds it to the
current active list. It requires at minimum the task name. In addition, there
are quite a few other parameters you can pass in.

    my $task = $gt->add_task(
        name      => 'Task Name',
        notes     => 'Notes',
        completed => 0,             # defaults false
        deleted   => 0,             # defaults false
        task_date => DateTime->now, # defaults null
    );

Note that "task\_date" is a DateTime object, but it's coerced into such when set.
So you can do stuff like this:

    $task->task_date('21/dec/93');
    $task->task_date->ymd; # returns "1993-12-21"

## drop\_task

This method drops a task based on the name of the task. It will look for the
first task in the current list that has a matching name and will delete it.

    $gt->drop_task('Task Name');

Note that you can have multiple tasks in a list with the same name. This
method will only delete the first match.

## task\_by\_name

This method returns the task object from the current active list that matches
the name provided.

    $gt->task_by_name('Task Name');

Note that you can have multiple tasks in a list with the same name. This
method will only delete the first match.

# TASK OBJECT METHODS

The following are methods of the list sub-library Google::Tasks::Task.

## new

This method instantiates a Google::Tasks::Task object and requires at minimum
the task name, the "root" object, which is the instantiated Google::Tasks
object, and either the list object or list ID of the list the task belongs to.
In addition, there are quite a few other parameters you can pass in.

    my $task = Google::Tasks::Task->new(
        name      => 'Task Name',
        root      => $gt,
        list      => $list_obj,
        list_id   => $list_obj->id,
        notes     => 'Notes',
        completed => 0,             # defaults false
        deleted   => 0,             # defaults false
        task_date => DateTime->now, # defaults null
    );

Typically, you're not going to want to use this method directly. Instead, use
the `add_task` helper method.

## save

This method saves changes made to the task metadata.

    $task->save;

The method returns a reference to the list.

## move

This method lets you move around tasks within a list, both in terms of relative
order, indenting (and outdenting), and moving tasks to other lists.

The simplest way to move tasks around on a list is to just change their order.
Assuming a flat set of tasks (no tasks are indented), you can select any task
on the list and tell `move()` to change its order based on an integer that
represents the index of what the task should be. For example, let's say you have
a task list with 4 tasks: A, B, C, D. You want to move A between C and D. You'd
do this:

    $task->move(2);

You can accomplish similar changes by telling `move()` to "up" or "down" a
task within a list.

    $task->move('down');
    $task->move('up');

And you can also pass `move()` either a task object or a list object. If you
pass it a list object, it will move the task to be under (indented) to that
task. For example, if you have a list with tasks A, B, C, and D, and you want
to move A indented under C:

    $task->move( $gt->task_by_name('Other Task') );

If you pass a list object, the task (and any of its subordinate tasks if any)
will get moved under the new list.

    $task->move($list);

## drop

This will delete the task.

    $task->drop;

# SEE ALSO

[Google::OAuth](https://metacpan.org/pod/Google::OAuth), [Google::API::Client](https://metacpan.org/pod/Google::API::Client), [Moo](https://metacpan.org/pod/Moo).

You can also look for additional information at:

- [GitHub](https://github.com/gryphonshafer/Google-Tasks)
- [CPAN](http://search.cpan.org/dist/Google-Tasks)
- [MetaCPAN](https://metacpan.org/pod/Google::Tasks)
- [AnnoCPAN](http://annocpan.org/dist/Google-Tasks)
- [Travis CI](https://travis-ci.org/gryphonshafer/Google-Tasks)
- [Coveralls](https://coveralls.io/r/gryphonshafer/Google-Tasks)

# AUTHOR

Gryphon Shafer <gryphon@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Gryphon Shafer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
