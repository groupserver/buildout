---------------------------------------------
GroupServer 10.11 — Kulfi Craved while Caving
---------------------------------------------

:Authors: Michael JasonSmith; Richard Waid; Alice Rose; Dan Randow
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2010-11-30
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

The changes below form the bulk of what is new in the Kulfi release of
GroupServer:

* Enhancements to groups, including a clearer `group properties page`_,
  a more flexible `delivery settings page`_, a simplified `start a
  group`_ process, and a new `group homepage about tab`_.
* `Management of a group member`_ is now easier.
* There have been some `set password`_  enhancements and `notification
  updates`_.
* Finally, the `buildout`_ process has been improved.

All these enhancements will be available to new GroupServer
installations, and those who `update an existing groupserver system`_.

Work is now progressing on GroupServer 10.12 — Lemon Ice in the Cool
of the Evening.

.. index::
   pair: Group; Properties

Group Properties Page
=====================

The page used to set the group properties has been simplified
[#GroupProperties]_, following a discussion about the properties
[#PropertiesTopic]_. There are fewer properties, as many properties
have been replaced by the `group homepage about tab`_. The properties
that remain have been given clearer names.

The new group properties page is now a standard ``zope.formlib`` form,
rather than relying on the older GroupServer ``XForms`` code. This
means that standard features of forms on GroupServer are present,
such as popup help.

.. index::
   pair: Group; Delivery settings

Delivery Settings Page
======================

The page used to change the email delivery settings of a group member
has been updated [#EmailSettings]_. The biggest advantage to the new
page is that administrators can now change the delivery settings of
group members.  For members the page looks and behaves much as it did
before. However, the system has undergone a major rework behind the
scenes. This will make the page easier to maintain, extend and change.

.. index::
   pair: Group; Start
   triple: Group; Type; Announcement

Start a Group
=============

The start a group system has been simplified to a one-step process
[#StartAGroup]_. Rather than a separate Preview step the new system
dynamically previews the URL and email address of the new group. It
also dynamically checks if the group identifier is unique.

It is not possible to create *announcement* groups with the simplified
system. However, announcement groups are still supported by GroupServer
and will continue to be supported. To create an announcement group
first create a discussion group. Then use the ZMI to change the
``group_template`` property to ``announcement``.

.. index::
   pair: Group; About
   pair: JavaScript; WYMeditor

Group Homepage About Tab
========================

The new group homepage about tab replaces the little-used Charter
page [#AboutTab]_. The new tab provides a blank area where a site
administrator is free to write any HTML. The WYMeditor is used to edit
the contents of the tab [#WYMeditorUse]_.

.. index::
   pair: Group member; Manage

Management of a Group Member
============================

A group administrator is now shown a *Manage Member* link when viewing
the profile of a member [#ManageMember]_. This should make managing
members even easier than before.

.. index::
   pair: Profile; Password

Set Password
============

The code used to set and reset passwords has been updated. Members
will be shown better error messages when they follow password-reset
links multiple times [#Password]_. In addition all the Set Password
pages have been updated to use a single text entry, rather than two
password entries [#EnClearPasswords]_.

.. index:: Notification

Notification Updates
====================

Some notifications that are stored in the ZMI have been updated. In
addition better feedback is given for those who fail to change the
group-delivery settings by email [#Notifications]_.

.. index::
   pair: Install; Buildout

Buildout
========

Buildout is the system that GroupServer uses to install the
system. The buildout process has been improved in three ways. First,
some issues with the environment relating to installing ``lxml`` have
been resolved [#lxml]_. Second, the standard system is used to add
the default administrator and user to the example group. This should
reduce the chance of errors occurring in the future. Finally, summary
information about the new GroupServer site is displayed at the end of
the buildout process. This should make it easier to start and view the
new GroupServer site.

Update an Existing GroupServer System
=====================================

To update an existing GroupServer system to Kulfi you will have to
`update the package versions`_, `update the SQL`_, and `update the
ZODB`_.

Update the Package Versions
---------------------------

Carry out the following steps to update the package versions.

#. Download the Kulfi tar-ball from `the GroupServer download page
   <http://groupserver.org/downloads>`_

#. Uncompress the tar-ball.

#. Copy the file ``groupserver-10.11/versions.cfg`` to your existing
   GroupServer installation.

#. In your existing GroupServer installation run::

      $ ./bin/buildout -N

Update the SQL
--------------

The `set password`_  enhancements require an update to the relational
database that stores GroupServer data. Carry out the following steps
to update the database.

#. In ``instance.cfg`` look up ``pgsql_dbname`` and the ``pgsql_user``,
   and note their values.

#. Run the following command::

      $ psql -U {psql_user} {psql_dbname} -c "ALTER TABLE "\
        "password_reset ADD COLUMN reset TIMESTAMP WITH TIME ZONE "\
        "DEFAULT NULL;"

Older installations will also have to update the table used to record
invitations::

      $ psql -U {psql_user} {psql_dbname} -c "ALTER TABLE "\
        "user_group_member_invitation ADD COLUMN initial_invite "\
        "BOOLEAN DEFAULT FALSE, ADD COLUMN withdrawn_date TIMESTAMP "\
        "WITH TIME ZONE, ADD COLUMN withdrawing_user_id TEXT;"

Update the ZODB
---------------

To get the `notification updates`_ into an existing GroupServer
system you will have to update the email-templates in the ZODB. Email
<support@onlinegroups.net> or `GroupServer Development`_ if you need
a hand with this.

.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.Net: https://onlinegroups.net/
.. _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
   http://creativecommons.org/licenses/by-sa/3.0/nz/
.. _GroupServer Development: http://groupserver.org/groups/development
.. _WYMeditor: http://www.wymeditor.org/
.. _Zope 2: http://zope2.zope.org/

.. [#GroupProperties] The new group properties page closes
   `Ticket 292 <https://redmine.iopen.net/issues/292>`_

.. [#PropertiesTopic] The GroupServer Development
   group hosted `a lively debate about topics
   <http://groupserver.org/r/topic/6ips13y2R228XK4dBYJTTl>`_

.. [#EmailSettings] Creating a new email-settings page closes `Ticket
   371 <https://redmine.iopen.net/issues/371>`_

.. [#StartAGroup] Simplifying the process used to start a group closes
   `Ticket 304  <https://redmine.iopen.net/issues/304>`_

.. [#AboutTab] Creating the About Tab closes `Ticket 493
   <https://redmine.iopen.net/issues/493>`_

.. [#WYMeditorUse] GroupServer uses the excellent `WYMeditor
   <http://www.wymeditor.org/>`_ as its HTML editor. Pages that use the
   editor include *Change Profile*, *Change Site Introduction* and all
   pages that are editable with the Content Manager (such as *About*
   and *Policies*.

.. [#ManageMember] Creating a link from the profile page to the manage
   member page closes `Ticket 515
   <https://redmine.iopen.net/issues/515>`_

.. [#Password] Knowing when a password has been reset closes `Ticket 326
   <https://redmine.iopen.net/issues/326>`_

.. [#EnClearPasswords] Why text entries are used to set passwords is
   explained in this `blog post
   <http://onlinegroups.net/blog/2010/10/22/change-password/>`_

.. [#Notifications] The clean up to notifications closes three tickets:

   #. `Ticket 205 <https://redmine.iopen.net/issues/205>`_
   #. `Ticket 231 <https://redmine.iopen.net/issues/231>`_
   #. `Ticket 531 <https://redmine.iopen.net/issues/531>`_

.. [#lxml] The ``lxml`` improvements should resolve `the issues that Tom
   had when installing GroupServer
   <http://groupserver.org/r/post/QeQVi7Zt4SgkNdPpZSyQl>`_

.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.Net: https://onlinegroups.net/
.. _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
   http://creativecommons.org/licenses/by-sa/3.0/nz/
.. _GroupServer Development: http://groupserver.org/groups/development
