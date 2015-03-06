===================
Getting GroupServer
===================

:Authors: `Michael JasonSmith`_;
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2015-03-06
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

..  _Creative Commons Attribution-Share Alike 4.0 International License:
    http://creativecommons.org/licenses/by-sa/4.0/

GroupServer_ is distributed as a compressed tar-file that you
download_. This file contains an **installation script for
Ubuntu** will install all the necessary dependencies_ that your
system currently lacks (see :doc:`groupserver-install`).

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

.. _dependencies:

Dependencies
============

For your erudition, the packages that contain the programs and
libraries that are required by GroupServer are listed for Ubuntu,
CentOS, and RedHat Enterprise Linux.

+-------------+-----------------------------------------------+
|             | Packages                                      |
+-------------+-----------------------+-----------------------+
| System      | Ubuntu                | CentOS 6.1 or         |
|             |                       | RHEL 6.1              |
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
| Database    +-----------------------+-----------------------+
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
| zlib (PNG)  | ``zlib1g-dev``        | ``zlib``              |
| Support     |                       +-----------------------+
|             |                       | ``zlib-devel``        |
+-------------+-----------------------+-----------------------+
| SMTP Test   | ``swaks``             | ``swaks``             |
+-------------+-----------------------+-----------------------+

..  _GroupServer: http://groupserver.org/
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.net: https://onlinegroups.net/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17

..  LocalWords:  CentOS RHEL postgresql devel postfix dev virtualenv swaks http
..  LocalWords:  groupserver
