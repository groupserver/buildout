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

.. highlight:: console

------------
Introduction
------------

The major `changes to GroupServer`_ in the Limonchello release
include XXX.  You can `get Limonchello`_ immediately.

----------------------
Changes to GroupServer
----------------------

Limonchello includes an `updated topic digest`_. Finally, there
have been some `minor code improvements`_.

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

Minor code improvements
=======================

* The HTML form of email notifications should render better in
  IBM Notes and Microsoft Outlook.
* A memory leak has been fixed.
* The rewriting of the message subject when the post has been
  forwarded from another group has been fixed.
* YouTube and Vimeo videos are now embedded using ``<iframe>``
  elements.
* The WAI-AIRA roles have been improved, closing `Issue 4156`_.

.. _Issue 4156: https://redmine.iopen.net/issues/4156

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

#.  Uncompress the tar-ball::

      $ tar cfz groupserver-15.xx.tar.gz

#.  Change to the directory that contains your existing
    GroupServer installation.

#.  Copy the new version-configuration files to your existing
    GroupServer installation::

      $ cp ../groupserver-15.xx/[bdiv]*cfg  .

#.  In your **existing** GroupServer installation copy the
    configuration file to its new location.

    #.  Make an ``etc`` directory::

          $ mkdir etc/

    #.  Move the configuration file to the new directory::

          $ cp parts/instance/etc/gsconfig.ini etc/

#.  Run ``buildout`` in your existing GroupServer installation::

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
..  _Creative Commons Attribution-Share Alike 4.0 International License:
    http://creativecommons.org/licenses/by-sa/4.0/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Dan Randow: http://groupserver.org/p/danr
..  _Bill Bushey: http://groupserver.org/p/wbushey
..  _Alice Rose: https://twitter.com/heldinz
..  _E-Democracy.org: http://forums.e-democracy.org/

..  LocalWords:  refactored iopen JPEG redmine jQuery jquery async Rakı Bushey
..  LocalWords:  Randow Organization sectnum Slivovica DMARC CSS Calvados AIRA
..  LocalWords:  SMTP smtp mbox CSV Transifex cfg mkdir groupserver Vimeo WAI
..  LocalWords:  buildout Limonchello iframe
