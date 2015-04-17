==================================================
GroupServer 15.xx — Limonchello to ward off summer
==================================================

:Authors: `Michael JasonSmith`_;
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2015-04-16
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

Finally, there have been some `minor code improvements`_.

Minor code improvements
=======================

* A memory leak has been fixed.
* The rewriting of the message subject when the post has been
  forwarded from another group has been fixed.
* YouTube and Vimeo videos are now embedded using ``<iframe>``
  elements.

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
..  LocalWords:  Randow Organization sectnum Slivovica DMARC CSS Calvados 
..  LocalWords:  SMTP smtp mbox CSV Transifex cfg mkdir groupserver Vimeo
..  LocalWords:  buildout Limonchello iframe
