.. index:: !Download

===================
Getting GroupServer
===================

:Authors: `Michael JasonSmith`_;
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2016-01-27
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

..  _Creative Commons Attribution-Share Alike 4.0 International License:
    https://creativecommons.org/licenses/by-sa/4.0/

The requirements_ for GroupServer_ are fairly light for a
stand-alone system. It is distributed as a compressed tar-file
that you download_. This file contains an **installation script
for Ubuntu** will install all the necessary dependencies_ that
your system currently lacks (see :doc:`groupserver-install`).

.. index:: !Requirements
   pair: Install; Requirements
   pair: Install; Virtual machine

.. _requirements:

System requirements
===================

GroupServer requires a Linux system, with a network connection,
and at least 1024MB of RAM [#lxml]_. (The default amount of RAM
for a virtual machine may be too small.) GroupServer and all its
libraries takes around 320MB of disk space, with more required to
store the messages, posted files, and other data.

.. index::
   pair: Install; Download

Download
========

GroupServer is distributed as a compressed tar-file. To download
the latest version of GroupServer

#. Visit <http://groupserver.org/downloads> and click
   ``Download``.

#. Extract GroupServer from the tar-file into a directory such as
   ``/opt``, ``/home`` or ``/usr/local``.

When the tar-file is extracted a new directory will be made.
This directory contains the configuration files for GroupServer.
In addition, the installation process will download and install
some dependencies into the directory (see
:doc:`groupserver-install`). GroupServer will be run from the
same directory.

:Permissions: You may need to be the superuser (``root``) to
       extract the archive. If you do then you **must** change
       the ownership of the new GroupServer directory and all of
       its contents to a normal user. GroupServer can only be run
       by users with normal privileges.

.. index:: !Dependencies, CentOS, RHEL, Ubuntu
.. _dependencies:

Dependencies
============

For your erudition, the packages that contain the programs and
libraries that are required by GroupServer are listed for Ubuntu,
CentOS, and RedHat Enterprise Linux. The installation script for
Ubuntu runs ``apt-get`` to install all the requisite packages
(see :doc:`groupserver-install`).

+-------------+-----------------------------------------------+
|             | Packages                                      |
+-------------+-----------------------+-----------------------+
| System      | Ubuntu                | CentOS 6.x or         |
|             |                       | RHEL 6.x              |
+=============+=======================+=======================+
| Python      | ``python2.7``         | ``python-devel``      |
|             +-----------------------+-----------------------+
|             | ``python2.7-dev``     | ``python-setuptools`` |
|             +-----------------------+-----------------------+
|             | ``python-virtualenv`` | See                   |
|             |                       | :ref:`centos-install` |
+-------------+-----------------------+-----------------------+
| GNU C++     | ``g++``               | ``gcc-c++``           |
+-------------+-----------------------+-----------------------+
| Make        | ``build-essential``   | ``make``              |
+-------------+-----------------------+-----------------------+
| PostgreSQL  | ``postgresql``        | ``postgresql``        |
| Database    |                       | See                   |
|             |                       | :ref:`centos-install` |
|             +-----------------------+-----------------------+
|             | ``libpq-dev``         | ``postgresql-server`` |
|             +-----------------------+-----------------------+
|             |                       | ``postgresql-libs``   |
|             +-----------------------+-----------------------+
|             |                       | ``postgresql-devel``  |
+-------------+-----------------------+-----------------------+
| Postfix     | ``postfix``           | ``postfix``           |
| Email       +-----------------------+-----------------------+
| Server      | ``postfix-dev``       |                       |
+-------------+-----------------------+-----------------------+
| Redis       | ``redis-server``      | ``redis``             |
+-------------+-----------------------+-----------------------+
| JPEG Support| ``libjpeg62-dev``     | ``libjpeg-devel``     |
+-------------+-----------------------+-----------------------+
| WebP Support| ``libwebp-dev``       |                       |
+-------------+-----------------------+-----------------------+
| zlib (PNG)  | ``zlib1g-dev``        | ``zlib``              |
| Support     |                       +-----------------------+
|             |                       | ``zlib-devel``        |
+-------------+-----------------------+-----------------------+
| SMTP Test   | ``swaks``             | ``swaks``             |
+-------------+-----------------------+-----------------------+

..  [#lxml] The RAM requirement is for `compiling lxml`_ during
            installation.
..  _compiling lxml: http://stackoverflow.com/a/25916353
..  _GroupServer: http://groupserver.org/
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.net: https://onlinegroups.net/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17

..  LocalWords:  CentOS RHEL postgresql devel postfix dev virtualenv swaks http
..  LocalWords:  groupserver
