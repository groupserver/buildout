=============================================
GroupServer 16.mm — Pastis proffered politely
=============================================

:Authors: `Michael JasonSmith`_;
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2015-12-09
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

The major `changes to GroupServer`_ in the Pastis release include
a new email-settings page. You can `get Pastis`_ immediately.

----------------------
Changes to GroupServer
----------------------

The `Email-settings page`_ is now easier to use with mobile
phones. Finally, there have been some `minor improvements`_.

Email-settings page
===================

The email-settings page allows people to add email addresses, and
set which addresses they prefer. The page has been updated so it
is easier to use with mobile devices, with buttons allowing
people to add and remove addresses from the list of
addresses. Using drag-and-drop between the lists still works for
those on desktop systems.

The underlying code now uses web-hooks and JSON to update the
email settings. This results in a far-faster page than before.

Finally, the dependencies on jQuery.UI and Twitter Bootstrap have
been removed.

Minor improvements
==================

* The code that determines if someone **can post** has been
  updated so it is more thoroughly tested.

----------
Get Pastis
----------

To get Pastis go to `the Downloads page for GroupServer`_
and follow `the GroupServer Installation documentation`_. Those
who already have a functioning installation can `update an
existing GroupServer system`_.

..  _The Downloads page for GroupServer: http://groupserver.org/downloads
..  _The GroupServer Installation documentation:
    http://groupserver.readthedocs.org/

Update an Existing GroupServer System
=====================================

To update a system running the Limoncello (15.11) release of
GroupServer to Pastis (16.mm) carry out the following steps.

#.  Copy the new versions of the configuration files to your
    existing GroupServer installation:

      ::

        $ cp ../groupserver-16.mm/[biv]*cfg  .

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
..  LocalWords:  buildout Limoncello iframe
