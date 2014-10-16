==============================================
GroupServer 14.xx — Calvados Consumed Covertly
==============================================

:Authors: `Michael JasonSmith`_;
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: (unreleased)
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

.. highlight:: console

------------
Introduction
------------

The major `changes to GroupServer`_ in the Calvados release
include improved internationalisation, and updated email
commands.  You can `get Calvados`_ immediately.

----------------------
Changes to GroupServer
----------------------

The most extensive change in Calvados is the
internationalisation_. There are also `updated email commands`_,
in addition to `minor code improvements`_.

Internationalisation
====================

`Alice Murphy`_ has lead an effort to add internationalisation to
GroupServer_. So far internationalisation has been added to the
following products

* The core page template that lays out the page
* The Join page
* The site homepage **[TODO]**
* The group page **[TODO]**
* The topic page **[TODO]**
* The post page **[TODO]**
* The image page **[TODO]**

Updated email commands
======================

The system for handling email commands have been completely
rewritten and improved. Five commands are currently supported.

:``Unsubscribe``: This is the most commonly used command. It
              removes the group-member that sent the command from
              the group. See `the gs.group.member.leave product`_
              for more information.
:``Subscribe``: This used to join a **public** group. A person
            who registers this way will be unable to log in,
            because he or she will have no password. In addition
            public groups are rare it has limited use. However,
            tradition dictates that a ``Subscribe`` command is
            supported. See `the gs.group.member.subscribe
            product`_ for more information.
:``Confirm``: This message, the companion to ``Subscribe``, is
              used to ensure that a person wants to join a
              group. See `the gs.group.member.subscribe product`_
              for more information.
:``Digest on``: This is used to switch to the topic-digest. See
              `the gs.group.member.email.settings product`_ for
              more information.
:``Digest off``: This is used to switch to one email per
              post. See `the gs.group.member.email.settings
              product`_ for more information.

.. _the gs.group.member.leave product:
   https://github.com/groupserver/gs.group.member.leave/
.. _the gs.group.member.subscribe product:
   https://github.com/groupserver/gs.group.member.subscribe
.. _the gs.group.member.email.settings product:
   https://github.com/groupserver/gs.group.member.email.settings

Minor code improvements
=======================

* Move to GitHub

------------
Get Calvados
------------

To get Calvados go to `the Downloads page for GroupServer`_ and
follow `the GroupServer Installation documentation`_. Those who
already have a functioning installation can `update an existing
GroupServer system`_.

..  _The Downloads page for GroupServer: http://groupserver.org/downloads
..  _The GroupServer Installation documentation: http://groupserver.org/downloads/install

Update an Existing GroupServer System
=====================================

To update a system running the Slivovica release of GroupServer
(14.06) to Calvados (14.xx) carry out the following steps.

#.  Download the Calvados tar-ball from `the GroupServer
    download page <http://groupserver.org/downloads>`_.

#.  Uncompress the tar-ball::

      $ tar cfz groupserver-14.xx.tar.gz

#.  Change to the directory that contains your existing
    GroupServer installation.

#.  Copy the new version-configuration files to your existing
    GroupServer installation::

      $ cp ../groupserver-14.xx/[bvz]*cfg  .

#.  In your existing GroupServer installation run::

      $ ./bin/buildout -n

#.  Restart your GroupServer instance.

:TODO: Update the table with the confirmation IDs for the new
       subscription command

---------
Resources
---------

- Code repository: https://github.com/groupserver/
- Questions and comments to http://groupserver.org/groups/development
- Report bugs at https://redmine.iopen.net/projects/groupserver

..  _GroupServer: http://groupserver.org/
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Creative Commons Attribution-Share Alike 4.0 International License:
    http://creativecommons.org/licenses/by-sa/4.0/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Dan Randow: http://groupserver.org/p/danr
..  _Bill Bushey: http://groupserver.org/p/wbushey
..  _Alice Murphy: http://groupserver.org/p/alice
..  _E-Democracy.org: http://forums.e-democracy.org/

..  LocalWords:  refactored iopen JPEG redmine jQuery jquery async
..  LocalWords:  Randow Organization sectnum Slivovica DMARC CSS
..  LocalWords:  SMTP smtp
