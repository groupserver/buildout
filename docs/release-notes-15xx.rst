==================================================
GroupServer 15.xx — Limonchello to ward off summer
==================================================

:Authors: `Michael JasonSmith`_;
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2015-04-24
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
include XXX.  You can `get Limonchello`_ immediately.

----------------------
Changes to GroupServer
----------------------

Limonchello includes an `updated topic digest`_, and a `profile
status notification`_. Finally, there have been some `minor
improvements`_.

Updated topic digest
====================

Group members can opt to receive a *daily topic digest* from a
group — rather than getting an email message every time someone
posts. The look of the digest, and the tools for sending the
digests have been significantly updated.

The topic digest now includes photos of the most recent person to
post to each topic. It is easier to

* Find the group from the digest,
* Post to a new topic, and
* Change your email settings.

The digests also look like standard email notifications, closing
`Feature 3985`_.

.. _Feature 3985: https://redmine.iopen.net/issues/3985

The :program:`sendigest` command, which is run once a day by
:program:`cron` to send the digests, has also been updated. It is
now faster, and now has a ``--verbose`` option for producing
verbose output, including a percentage-progress indicator.

Profile status notification
===========================

GroupServer now has the ability to send out a notification that
reminds people about their profile status, what groups they are
in, and encourages the group members to enhance their
profiles. The new *What is going on in your groups* notification
is designed to be sent out once a month (towards the start of
every month), and includes a new :program:`sendprofile` command —
which works much like the :program:`senddigest` command that
sends out the daily digest of topics (see :doc:`cron` for more
information).

There is also two new email-commands: ``Status off`` and ``Status
on``. The former records that the person wishes to stop receiving
the monthly summary, the latter turns it on. Both work for a
*support* group.

The creation of a profile status notification closes `Feature
370`_.

.. _Feature 370: https://redmine.iopen.net/issues/370

Web hooks
=========

For a long time GroupServer has used *web hooks* to expose
functionality to outside systems. For example, the scripts
:program:`mbox2gs`, :program:`smtp2gs`, :program:`senddigest` and
the new :program:`sendprofile` (see `Profile status
notification`_) all use web hooks.

Thanks to **our generous sponsors** some *generic* web-hooks have
been added.

* Discover all the groups on a site.
* Remove someone from a group.
* Search for someone by email address.
* List all the site members.

Implementing the web-hooks closes `Issue 262`_.

.. _Issue 262: https://redmine.iopen.net/issues/262

Minor improvements
==================

* Email notifications should render better in IBM Notes and
  Microsoft Outlook.
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
* The scripts that use webhooks now handle 301 redirects
  correctly, closing `Bug 4162`_.

.. _Issue 4156: https://redmine.iopen.net/issues/4156
.. _Bug 4162: https://redmine.iopen.net/issues/4162

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
    database:

      ::

        $ psql -U {psql_user} {psql_dbname} -i \
          eggs/gs.profile.status.base-*/gs/profile/status/base/sql/01-skip.sql

    Where ``{psql_user}`` and ``{psql_dbname}`` are the names of
    the PostgreSQL user and relational-database used by
    GroupServer.

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
