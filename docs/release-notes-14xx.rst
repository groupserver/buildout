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
better `reporting of bouncing email addresses`_, and the new
`change group-type`_ page. Finally there have been some `minor
code improvements`_.

Internationalisation
====================

`Alice Murphy`_ has lead an effort to add internationalisation to
GroupServer_. So far internationalisation support has been added
to the following products.

* The core page template that lays out the page
* The Join page
* The site homepage **[TODO]**
  
  + The *Welcome* area and *Change welcome* page
  + The *About* area and *Change about* page
  + The *Admin* area
  + The *Groups* lists
  + The *Topics* list

* The *Change site name* page
* The *Change site timezone* page
* The *Start a group* page
* The *Search for a site member* page

* The group page **[TODO]**
* The topic page **[TODO]**
* The post page **[TODO]**
* The image page **[TODO]**
* The *Change group properties* page

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

The implementation of the new email commands closes `Bug 3403`_.

.. _the gs.group.member.leave product:
   https://github.com/groupserver/gs.group.member.leave/
.. _the gs.group.member.subscribe product:
   https://github.com/groupserver/gs.group.member.subscribe
.. _the gs.group.member.email.settings product:
   https://github.com/groupserver/gs.group.member.email.settings
.. _Bug 3403: https://redmine.iopen.net/issues/3403

Reporting of bouncing email addresses
=====================================

When an email message cannot be delivered often a *bounce*
message will be set back to the system that sent the message. For
many years GroupServer has kept track of these bounce messages;
if an address of a group-member causes bounces on five separate
days in a 60 day window then that email address is set to
*unverified.*

The new *Bounces* page now shows the group administrator a record
of the bouncing email addresses. In addition a notification is
sent to the administrator when the email address of a group
member is disabled. If the member has any additional email
addresses then notifications is sent to these addresses also.

The updating of the bounce-handling system closes `Feature
3614`_, `Feature 3772`_ and `Feature 3773`_.

.. _Feature 3614: https://redmine.iopen.net/issues/3614
.. _Feature 3772: https://redmine.iopen.net/issues/3772
.. _Feature 3773: https://redmine.iopen.net/issues/3773

Change group-type
=================

There are four types of group supported by GroupServer: 

* Discussion groups such as `GroupServer development`_, 
* Announcement group such as `GroupServer announcements`_,
* Support groups such as ``support@onlinegroups.net``, and
* Closed groups.

Calvados introduces the *Change group-type* page, which allows
the type of group to be quickly and easily changed, closing
`Feature 702`_.

.. _GroupServer development: https://groupserver.org/groups/development
.. _GroupServer announcements: http://groupserver.org/groups/groupserver_announcements/
.. _Feature 702: https://redmine.iopen.net/issues/702

Minor code improvements
=======================

* `The primary code repository for GroupServer`_ is now at
  GitHub. We hope that this will make GroupServer easier for
  others to work on.

* The *Change image* page is now in its own product,
  ``gs.profile.image.edit``, closing `Feature 601`_

* The notifications that are sent out when someone leaves a group
  have been updated, closing `Feature 4061`_.

* The subject-line prefix is correctly set when changing the
  general group properties, closing `Bug 640`_.

.. _The primary code repository for GroupServer:
   https://github.com/groupserver/
.. _Feature 4061: https://redmine.iopen.net/issues/4061
.. _Feature 601: https://redmine.iopen.net/issues/601
.. _Bug 640: https://redmine.iopen.net/issues/640

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
