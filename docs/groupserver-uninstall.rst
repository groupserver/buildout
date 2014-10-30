==================
Remove GroupServer
==================

:Authors: `Michael JasonSmith`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2014-10-30
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

..  _Creative Commons Attribution-Share Alike 4.0 International License:
    http://creativecommons.org/licenses/by-sa/4.0/

.. highlight:: console

To remove GroupServer_, you must remove the database, the
associated database user, and the directory that contains the
GroupServer install.

1. To remove the database, run the following commands::

    $ dropdb gstestdb -U postgres
    $ dropuser gstest -U postgres

  ``gstestdb``
    The name of the test database.

  ``postgres``
    The name of the admin of PostgreSQL.

  ``gstest``
    The name of the PostgreSQL user.

2. Remove the directory that contains the GroupServer install::

    $ rm -r groupserver-14.03

.. _GroupServer: http://groupserver.org/
.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.net: https://onlinegroups.net/
.. _Ubuntu: http://www.ubuntu.com/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
