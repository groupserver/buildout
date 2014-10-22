===================
Configuring Postfix
===================

:Authors: `Michael JasonSmith`_; `Fabien Hespul`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2014-06-23
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

.. highlight:: console

Postfix provides the email interface for GroupServer. GroupServer
uses Postfix to:

* Queue email that is delivered to groups, and
* Pass the email messages to GroupServer.

Configuration files for the Postfix_ mail server are created when
GroupServer_ is installed. However, it is necessary to change
some configuration files so Postfix will send email messages on
to GroupServer.

:See also: If you are new to administering Postfix you may find
           the `Ubuntu Community Postfix Documentation`_ useful.

.. _Ubuntu Community Postfix Documentation: https://help.ubuntu.com/community/Postfix

Postfix has to know to run two scripts when email messages come
in for your GroupServer site. Below are the steps for configuring
Postfix for either Debian or Ubuntu. (**Note:** You will need to
be the root user to carry out most of these tasks.)

#.  Copy the configuration files from the GroupServer
    installation into the Postfix configuration directory::

      # cp postfix_config/groupserver.* /etc/postfix

#.  Change the ownership of the files to the Postfix user and
    group. For Ubuntu this would be::

      # chown nobody.nogroup /etc/postfix/groupserver.*

    If you are on a system other than Ubuntu, running the
    following will display the user-name of the Postfix user::
  
      $ /usr/sbin/postconf | grep default_privs | cut -f3 -d" "

#.  Open the file ``/etc/postfix/main.cf`` in a text editor.

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
