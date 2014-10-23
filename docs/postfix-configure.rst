===================
Configuring Postfix
===================

:Authors: `Michael JasonSmith`_; `Fabien Hespul`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2014-10-22
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

.. highlight:: console

Introduction
============

Postfix provides the email interface for GroupServer. GroupServer
uses Postfix to:

* Queue email that is delivered to groups, and
* Pass the email messages to GroupServer.

Configuration files for the Postfix_ mail server are created when
GroupServer_ is installed. However, it is necessary to change the
main Postfix configuration files so Postfix will send email
messages on to GroupServer.

:See also: If you are new to administering Postfix you may find
           the `Ubuntu Community Postfix Documentation`_ useful.

.. _Ubuntu Community Postfix Documentation:
   https://help.ubuntu.com/community/Postfix

Postfix configuration
=====================

The Postfix configuration will achieve the following.

* **One single address** will respond to all emails coming in to
  *any possible* group on your site.
* When an email comes in for *any* group on a it is passed on to
  GroupServer.

There are two configuration files, created by GroupServer during
installation, that will provide what we want once they have been
integrated into the existing Postfix configuration. Below are the
steps for configuring Postfix for either Debian or Ubuntu.

:Note: You will need to be the root user to carry out most of
       these tasks.

#.  Copy the configuration files from the GroupServer
    installation into the Postfix configuration directory::

      # cp postfix_config/groupserver.* /etc/postfix

#.  Change the ownership of the files to root::

      # chown root.root /etc/postfix/groupserver.*

    If you are on a system other than Ubuntu you will need to
    ensure that the files are owned by the Postfix user. Running
    the following will display the user-name of the Postfix
    user::
  
      $ /usr/sbin/postconf | grep default_privs | cut -f3 -d" "

#.  Open the file ``/etc/postfix/main.cf`` in a text editor.

.. Up to here

#.  Find the line that begins with ``alias_maps``.

#.  Add the item ``hash:/etc/postfix/groupserver.virtual`` to the
    end of the ``alias_maps`` line. Use a comma to separate the
    new item from the existing items.

#.  Find the line that begins with ``alias_database``.

#.  Add the item ``hash:/etc/postfix/groupserver.virtual`` to the
    end of the ``alias_database`` line. Use a comma to separate
    the new item from the existing items.

#.  Add the following to the bottom, unless it is previously
    defined

    .. code-block:: cfg

      smtpd_authorized_verp_clients = 127.0.0.1

#.  Generate the Postfix hashes::

    # postmap /etc/postfix/groupserver.virtual
    # postalias /etc/postfix/groupserver.aliases

#.  Restart Postfix::

    # service postfix restart

.. _GroupServer: http://groupserver.org/
.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.net: https://onlinegroups.net/
..  _Postfix: http://www.postfix.org/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Creative Commons Attribution-Share Alike 4.0 International License:
    http://creativecommons.org/licenses/by-sa/4.0/
..  _Fabien Hespul: http://groupserver.org/p/1e38zikXDqFgXFkmCjqC31

..  LocalWords:  Organization Postfix
