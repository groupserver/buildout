.. index::
   single: Postfix
   single: postmap
   single: postalias
   pair: Email; SMTP
   pair: Email; Configuration
   pair: Install; Mail server

==============================
Configuring :command:`postfix`
==============================

:Authors: `Michael JasonSmith`_; `Fabien Hespul`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2015-06-22
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

..  _Creative Commons Attribution-Share Alike 4.0 International License:
    https://creativecommons.org/licenses/by-sa/4.0/

.. highlight:: console

Introduction
============

Postfix_ provides the email interface for
GroupServer_. GroupServer uses Postfix to queue email that is
delivered to groups, and pass the email messages to GroupServer.

Configuration files for Postfix that are specific to GroupServer
are created when GroupServer is installed. However, it is
necessary to change the main `Postfix configuration`_ files for
the system so Postfix will send email messages on to
GroupServer. The Postfix configuration will achieve the
following.

* Each group will have a unique email address.
* The Postfix configuration will work, untouched, for any and all
  groups once it has been set up.
* A single **virtual address** will respond to all emails coming
  in to *any possible* group on your site.
* When an email comes in for *any* group on a it is passed on to
  GroupServer, which then adds the message to the correct group.

There are two configuration files, created by GroupServer during
installation, that will provide what we want once they have been
integrated into the existing Postfix configuration. Both are
found in the ``postfix_config`` directory after GroupServer has
been built.

``groupserver.virtual``:
    This file maps all email messages that are sent to any of
    your GroupServer groups to the single
    ``groupserver-automagic@localhost`` email-address. See
    :manpage:`virtual(5)` for more information.

``groupserver.aliases``:
    This file maps the ``groupserver-automagic`` address to a
    command: piping the email to the smtp2gs_ script. See
    :manpage:`aliases(5)` for more information.

.. _smtp2gs: http://github.com/groupserver/gs.group.messages.add.smtp2gs

.. seealso:: `The Ubuntu Community Postfix Documentation`_ is
             useful if you are new to administering Postfix.

.. _The Ubuntu Community Postfix Documentation:
   https://help.ubuntu.com/community/Postfix

Postfix configuration
=====================

Below are the steps for configuring Postfix for either Debian or
Ubuntu.

.. note:: You will need to be the ``root`` user to carry out most
          of these tasks. Commands that need to be run as root
          will be shown with ``#`` prompt, rather than a ``$``.

#.  Copy the configuration files from the GroupServer
    installation into the Postfix configuration directory.

      .. code-block:: console

        # cp postfix_config/groupserver.* /etc/postfix

#.  Change the ownership of the files to root:

    .. code-block:: console

      # chown root.nogroup /etc/postfix/groupserver.*

    If you are on a system other than Ubuntu you will need to
    ensure that the files are owned by the Postfix user. Running
    the following will display the user-name of the Postfix
    user.

      .. code-block:: console

        $ /usr/sbin/postconf | grep default_privs | cut -f3 -d" "

#.  Open the file :file:`/etc/postfix/main.cf` in a text editor.

#. Update the aliases.

   #.  Find the line that begins with ``alias_maps``.

   #.  Add the item ``hash:/etc/postfix/groupserver.aliases`` to
       the end of the ``alias_maps`` line. Use a comma to
       separate the new item from any existing items. For example

         .. code-block:: cfg

            alias_maps = hash:/etc/aliases,hash:/etc/postfix/groupserver.aliases

   #.  Find the line that begins with ``alias_database``.

   #.  Add the item ``hash:/etc/postfix/groupserver.aliases`` to
       the end of the ``alias_database`` line. Use a comma to
       separate the new item from any existing items. For
       example

         .. code-block:: cfg

            alias_database = hash:/etc/aliases,hash:/etc/postfix/groupserver.aliases

#. Update the virtual alias.

   #. Find the line that begins with ``virtual_alias_maps``. If
      no line exists add one after the ``alias_database`` line.

   #. Add the item ``hash:/etc/postfix/groupserver.virtual`` to
      the end of the ``virtual_alias_maps`` line. For example

        .. code-block:: cfg

           virtual_alias_maps = hash:/etc/postfix/groupserver.virtual

#.  Add the following to the bottom of the :file:`main.cf` file,
    unless it is previously defined

      .. code-block:: cfg

         smtpd_authorized_verp_clients = 127.0.0.1,localhost

#.  Generate the Postfix hashes by running :command:`postmap` and
    :command:`postalias`:

      .. code-block:: console

        # postmap /etc/postfix/groupserver.virtual
        # postalias /etc/postfix/groupserver.aliases

#.  Restart :command:`Postfix` using :command:`service`:

      .. code-block:: console

        # service postfix restart

.. seealso:: More information about the GroupServer
             :program:`smtp2gs` command — including optional
             arguments, return values, and examples — is
             available from `the smtp2gs documentation.`_

.. _the smtp2gs documentation.: http://groupserver.readthedocs.io/projects/gsgroupmessagesaddsmtp2gs/en/latest/script.html


.. _GroupServer: http://groupserver.org/
.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.net: https://onlinegroups.net/
..  _Postfix: http://www.postfix.org/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Fabien Hespul: http://groupserver.org/p/1e38zikXDqFgXFkmCjqC31

..  LocalWords:  Organization Postfix
