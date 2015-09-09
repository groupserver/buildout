==================================================
GroupServer 15.xx — Limonchello to ward off summer
==================================================

:Authors: `Michael JasonSmith`_;
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2015-07-30
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International
  License`_ by `OnlineGroups.net`_.

..  _Creative Commons Attribution-Share Alike 4.0 International License:
    https://creativecommons.org/licenses/by-sa/4.0/

.. highlight:: console

------------
Introduction
------------

The major `changes to GroupServer`_ in the Limonchello release
include HTML formatting of posts, better notifications, and more
ways to connect with other systems.  You can `get Limonchello`_
immediately.

----------------------
Changes to GroupServer
----------------------

The most visible change to GroupServer in this release is `HTML
formatting in posts`_. Limonchello also includes an `updated
topic digest`_, a new `profile status notification`_, the
introduction of `restricted groups`_, `updated member
management`_, new `web hooks`_, more `code documentation`_, and
an improved `German translation of GroupServer`_. Finally, there
have been some `minor improvements`_.

HTML formatting in posts
========================

With the Limonchello release GroupServer now will format email
messages from a group using HTML — in addition to sending a
plain-text version of the message. The HTML form of the message
includes additional metadata about the post:

* The profile image of the person who made the post
* The name of the topic that the post belongs to
* The name of the person who made the post, and a link to their
  profile
* The full name of the group, and a link to the group
* Links that make it easy to

  + Reply to the post
  + Start a new topic
  + View the topic on the web
  + Leave the group
  + Switch to a daily digest of topics

The HTML version of the email is generated from the **plain
text** version of the post. However, the post is formatted in
much the same way as the post on the web: text in ``*asterisks*``
is made bold, quoted text (``> like this``) is muted, and people
can click on email addresses, URLs, and site names. Attachments
are still stripped, and replaced with links to the files on the
web.

Sending a HTML formatted message based on a plain-text email
closes `Feature 4160`_.

.. note::

   We hope to generate the HTML form of an email from the submitted
   HTML in a future version of GroupServer. This task is tracked in
   `Feature 3676`_.

.. _Feature 3676: https://redmine.iopen.net/issues/3676
.. _Feature 4160: https://redmine.iopen.net/issues/4160

Updated topic digest
====================

Group members can opt to receive a *daily topic digest* from a
group — rather than getting an email message every time someone
posts. The Limonchello release includes significantly updates to
the look of the digest, and the tools for sending the digests.

* The digests look like standard email notification, closing
  `Feature 3985`_.

* The digest now includes a photo of the most recent person to
  post to each topic.

* It is now easier to

  + Find the group from the digest,
  + Post to a new topic, and
  + Change your email settings.

The :program:`sendigest` command, which is run once a day by
:program:`cron` to send the digests, has also been updated. It is
now faster, and now has a ``--verbose`` option for producing
verbose output, including a percentage-progress indicator.

Because the new `profile status notification`_ reminds people
that they are in groups the **weekly** topic digest, which was
sent when there was no activity in a group for a week, is no
longer sent.

.. _Feature 3985: https://redmine.iopen.net/issues/3985

Profile status notification
===========================

GroupServer now has the ability to send out a notification that
reminds people about their profile status, what groups they are
in, and encourages the group members to enhance their
profiles. The new *What is going on in your groups* notification
is designed to be sent out once a month (towards the start of
every month). The system includes a new :program:`sendprofile`
command — which works much like the :program:`senddigest` command
that sends out the daily digest of topics (see :doc:`cron` for
more information).

There are also two new email-commands: ``Status off`` and
``Status on``. The former records that the person wishes to stop
receiving the monthly summary, the latter turns it on. Both work
for a *support* group.

The creation of a profile status notification closes `Feature
370`_.

.. _Feature 370: https://redmine.iopen.net/issues/370

Restricted groups
=================

A new privacy level has been added to GroupServer in the
Limonchello release: *restricted groups.* Everyone that is a
member of the **site** can see a restricted group, and the posts
within it. It joins the three existing privacy levels:

* Public, where the group and posts are shown to everyone,
* Private, where only group-members can see the posts, and
* Secret, where only members can see the group and posts.

The different privacy levels can be set from the *Change privacy*
page, linked from the *Admin* area of the group page.

Allowing the restricted group-type to be set closes `Feature
4169`_.

.. _Feature 4169: https://redmine.iopen.net/issues/4169

Configurable :mailheader:`Reply-to`
===================================

The :mailheader:`Reply-to` header for posts sent from a group can
now be easily configured — using the *Reply to* property on the
*General group properties* page, which is linked from the *Admin*
section of the group page. In the Rakı release of we added the
ability for GroupServer to change the :mailheader:`Reply-to`
header to the email address of author of the post, the group, or
both (see :ref:`rebuilt email processing`). However, there was
never an easy way to change what the value should be. Adding this
ability closes `Feature 4051`_.

.. _Feature 4051: https://redmine.iopen.net/issues/4051

Updated member management
=========================

The *Manage members* page has been updated to make it easier to use.

* 48 people are now shown on every page, rather than just 20.
* The *Manage many members* page is now shown when there is
  more than 48 members in a group, rather than 127.
* The list of people on the *Manage many members* page is now
  sorted by name.

Web hooks
=========

For a long time GroupServer has used *web hooks* to expose
functionality to outside systems. For example, the scripts
:program:`mbox2gs`, :program:`smtp2gs`, :program:`senddigest` and
the new :program:`sendprofile` (see `Profile status
notification`_) all use web hooks.

Thanks to `Team Z`_ some *generic* web-hooks have been added:

* `Discover`_ all the groups on a site.
* `Add`_ someone to a group.
* `Search`_ for someone by email address.
* `List`_ all the site members.
* `Remove`_ someone from a group.

The is also a new overview of the avaliable hooks (see
:doc:`webhook`).

Implementing the web-hooks closes `Issue 262`_.

.. _Team Z: http://triteamz.com/
.. _Discover:
   http://groupserver.readthedocs.org/projects/gsgroupgroupsjson/en/latest/hook.html
.. _Add:
   http://groupserver.readthedocs.org/projects/gsgroupmemberaddjson/en/latest/hook.html
.. _Search:
   http://groupserver.readthedocs.org/projects/gssearchpeople/en/latest/hook.html
.. _List:
   http://groupserver.readthedocs.org/projects/gssitememberjson/en/latest/hook.html
.. _Remove:
   http://groupserver.readthedocs.org/projects/gsgroupmemberleavejson/en/latest/hook.html
.. _Issue 262: https://redmine.iopen.net/issues/262

German translation of GroupServer
=================================

Far more of the GroupServer user-interface has been translated
into German, thanks to the diligent work of Cousin Clara.

Code documentation
==================

The documentation for the low-level system continues to improve
in the Limonchello release. Many system now have documentation
available on `Read the Docs`_, including all the scrips that are
generated during installation. The document components of
GroupServer are listed as `sub-projects of GroupServer`_ on Read
the Docs.

.. _Read the Docs: https://readthedocs.org/
.. _sub-projects of GroupServer:
   https://readthedocs.org/projects/groupserver/

Minor improvements
==================

* Email notifications should render better in IBM Notes, and
  Microsoft Outlook on Windows.
* Some memory leaks have been fixed.
* The rewriting of the ``Subject`` of an email message when the
  post has been forwarded from another group has been fixed.
* YouTube and Vimeo videos are now embedded using ``<iframe>``
  elements.
* The WAI-AIRA roles have been improved, closing `Issue 4156`_.
* An error with a link in the *Unknown email address*
  notification has been fixed.
* An error with a link to the profile from the *Member has left*
  notification has been fixed.
* The scripts that use web hooks now handle 301 redirects
  correctly, closing `Bug 4162`_.
* Links in email messages can now use ``https://`` as the
  protocol, closing `Bug 4171`_. For more information see
  :ref:`secure connections`.

.. _Issue 4156: https://redmine.iopen.net/issues/4156
.. _Bug 4162: https://redmine.iopen.net/issues/4162
.. _Bug 4171: https://redmine.iopen.net/issues/4171

---------------
Get Limonchello
---------------

To get Limonchello go to `the Downloads page for GroupServer`_
and follow `the GroupServer Installation documentation`_. Those
who already have a functioning installation can `update an
existing GroupServer system`_.

..  _The Downloads page for GroupServer: http://groupserver.org/downloads
..  _The GroupServer Installation documentation:
    http://groupserver.readthedocs.org/

Update an Existing GroupServer System
=====================================

To update a system running the Rakı release of GroupServer
(15.03) to Limonchello (15.xx) carry out the following steps.

#.  Download the Limonchello tar-ball from `the GroupServer
    download page <http://groupserver.org/downloads>`_.

#.  Uncompress the tar-ball:

      ::

        $ tar cfz groupserver-15.xx.tar.gz

#.  Change to the directory that contains your existing
    GroupServer installation.

#.  Add the ``profile_notification_skip`` table to the relational
    database. Download `the SQL definition of the table`_ and
    execute the SQL using the following command:

      ::

        $ psql -U {psql_user} {psql_dbname} -i {filename}

    Where ``{psql_user}`` and ``{psql_dbname}`` are the names of
    the PostgreSQL user and relational-database used by
    GroupServer (as recorded in :file:`config.cfg`, see
    :doc:`groupserver-install`). The final argument is the name
    of the SQL file you downloaded (probably
    :file:`01-skip.sql`).

#.  Copy the new version-configuration files to your existing
    GroupServer installation:

      ::

        $ cp ../groupserver-15.xx/[bdiv]*cfg  .

#.  In your **existing** GroupServer installation copy the
    configuration file to its new location.

    #.  Make an ``etc`` directory:

          ::

            $ mkdir etc/

    #.  Move the configuration file to the new directory:

          ::

            $ cp parts/instance/etc/gsconfig.ini etc/

#.  Run ``buildout`` in your existing GroupServer installation:

      ::

        $ ./bin/buildout -N

#.  Restart your GroupServer instance (see
    :doc:`groupserver-start`).

.. _the SQL definition of the table:
  https://raw.githubusercontent.com/groupserver/gs.profile.status.base/master/gs/profile/status/base/sql/01-skip.sql

---------
Resources
---------

- Code repository: https://github.com/groupserver/
- Questions and comments to
  http://groupserver.org/groups/development
- Report bugs at https://redmine.iopen.net/projects/groupserver

..  _GroupServer: http://groupserver.org/
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Dan Randow: http://groupserver.org/p/danr
..  _Bill Bushey: http://groupserver.org/p/wbushey
..  _Alice Rose: https://twitter.com/heldinz
..  _E-Democracy.org: http://forums.e-democracy.org/

..  LocalWords:  refactored iopen JPEG redmine jQuery jquery async Rakı Bushey
..  LocalWords:  Randow Organization sectnum Slivovica DMARC CSS Calvados AIRA
..  LocalWords:  SMTP smtp mbox CSV Transifex cfg mkdir groupserver Vimeo WAI
..  LocalWords:  buildout Limonchello iframe
