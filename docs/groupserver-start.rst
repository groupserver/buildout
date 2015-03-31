=================================
Starting and stopping GroupServer
=================================

:Authors: `Michael JasonSmith`_; `Richard Waid`_; 
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2015-03-30
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

.. highlight:: console

Introduction
============

In this document we present a quick introduction to starting
GroupServer_.  First you have to install GroupServer, which is
covered in the ``groupserver-install.txt`` file in the ``docs/``
directory of your GroupServer folder, `or online.`_ Here we will
cover `trying out GroupServer`_, and `running
GroupServer`_. Finally, we try and deal with some `issues, and
problems`_.

.. _or online.: http://groupserver.org/downloads/install/

Trying out GroupServer
======================

The first time you fire-up GroupServer it is reassuring to see
all the debugging information, in case there is an error. 

Starting GroupServer for the first time
---------------------------------------

Once GroupServer has been installed you should be able to start
it with the command in the GroupServer installation directory::

  $ ./bin/instance fg

This starts the Zope_ instance, which runs GroupServer, in
*foreground* mode.

Access the ZMI
--------------

Generally most configuration can be done from the Web interface
of GroupServer. However the *Zope Management Interface* can be
used to perform some low-level tasks, and accessing it is a good
indication that everything is working correctly. The ZMI is
accessed by visiting ``http://{zope_host}:{zope_port}/manage``:

``zope_host``:
  The name of the Zope host, that you set in the ``config.cfg``
  file.

``zope_port``:
  The port of the Zope host, that you set in the ``config.cfg``
  file.

If the defaults are unaltered then the URL for the ZMI will be
<http://localhost:8080/manage/>. If all is well you will be
prompted for a user-name and password. These will be the
``zope_admin`` and ``zope_password`` that you set in the
``config.cfg``.

In the ZMI you should see a ``groupserver`` folder. Within that a
``Contents`` folder, leading to an ``initial_site``, ``groups``
and finally ``initial_group``.

Access your site
----------------

If you can `access the ZMI`_ without any problems then the next
thing to test is if you can access your site. If you have
configured DNS or your local host file correctly, you should be
able to access your site at ``http://${host}:${port}``:

``host``:
  The name of the GroupServer host, that you set in the
  ``config.cfg`` file.

``port``:
  The port that GroupServer is listening to, that you set in the
  ``config.cfg`` file.

If you left the defaults unaltered then the URL for your
GroupServer site will be <http://gstest:8080/>.

Log in
~~~~~~

Log in as an administrator by clicking the *Sign in* link and
entering the ``admin_email`` and ``admin_password`` you set in
the ``config.cfg`` file.

Stop the test
-------------

To stop testing type ``Control-c`` in the terminal where
GroupServer is running.

Running GroupServer
===================

Running GroupServer on a more permanent basis requires starting
the Zope instance as a demon, and keeping a track of `the log
file`_

**Start** the Zope instance as a demon by running the following
command from the GroupServer installation directory::

  $ ./bin/instance start

**Stop** the demon by running the following command::

  $ ./bin/instance stop

The log file
------------

The log file is ``var/log/instance.cfg``, located withing the
GroupServer directory.

Issues, and problems
====================

Please, ask questions and make comments in `the GroupServer
Development group`_, or in the gsdevel IRC channel on Freenode
(``irc://irc.freenode.net/#gsdevel``). `The log file`_ will
usually contain relevant information, including copies of any
errors.

Virtual machines
----------------

With virtual machines it can be difficult to connect from your
desktop — which has a Web browser — to GroupServer running on the
hosted machine. The documentation for your chosen virtual
environment should cover how to expose the network interface for
a hosted Web service, such as GroupServer.

.. _the GroupServer Development group: http://groupserver.org/groups/development
.. _GroupServer: http://groupserver.org/
.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.net: https://onlinegroups.net/
.. _Zope: http://zope.org
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Richard Waid: http://groupserver.org/p/richard
..  _Creative Commons Attribution-Share Alike 4.0 International License:
    http://creativecommons.org/licenses/by-sa/4.0/

..  LocalWords:  fg ZMI richard sa groupserver http localhost
..  LocalWords:  config cfg gstest zope txt gsdevel irc Freenode
..  LocalWords:  freenode
