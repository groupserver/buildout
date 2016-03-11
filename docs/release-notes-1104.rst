----------------------------------------------------------
GroupServer 11.04 — Slushy Followed by a Pounding Headache
----------------------------------------------------------

:Authors: Michael JasonSmith; Richard Waid; Dan Randow
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2011-04-29
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

The Slushy release of GroupServer contains two main
`enhancements`_. You can `get Slushy`_ immediately. Work is now
starting on GroupServer 11.05 — Eskimo Pie with Middle-Class
Guilt.

Enhancements
============

The two main enhancements to GroupServer are

* Posts can now be hidden (see `Hide a Post`_ below) and
* `Full email addresses`_ can now be used to issue invitations.

There are also some `minor fixes`_.

Hide a Post
-----------

The most significant change to GroupServer is the introduction of an
interface to allow posts to be hidden [#HideAPost]_. Both administrators
and the author of the post can hide it. People trying to view the post,
by itself or in a topic, will see the reason the post was hidden instead
of the message. Anyone trying to view a file or image that was added
as part of the post will see an error-page that states why the post
was hidden.

Full Email Addresses
--------------------

Prior to Slushy GroupServer would only accept the portion of an email
address with an ``@`` in it — such as ``support@onlinegroups.net``. Now
the *Invite a New Member* page can handle the full address. This
address can include a name, such as ``"OnlineGroups.Net Support"
<support@onlinegroups.net>`` [#FullAddress]_. Other pages will be
converted to support full addresses over time.

.. index::
   pair: JavaScript; jQuery.UI

Minor Fixes
-----------

Minor fixes in Slushy include

* A fix to the *Join and Leave Log* so it now uses jQuery UI tabs
  [#LogTabs]_,
* A fix to the *view* link in the content editor so it works
  [#ViewLink]_, and
* Resolving an error with the *Change Email Settings* page that occurred
  when someone had no preferred email address set [#EmailSettings]_.

Get Slushy
==========

To get Slushy go to `the Downloads page for GroupServer
<http://groupserver.org/downloads>`_ and follow `the GroupServer
Installation documentation <http://groupserver.org/downloads/install>`_.

Those who already have a functioning installation can `update an existing
GroupServer system`_.

Update an Existing GroupServer System
-------------------------------------

To upgrade an existing GroupServer system to Slushy you must first
`update the database`_ and then `update the packages`_.

Update the Database
~~~~~~~~~~~~~~~~~~~

The `hide a post`_ update requires a change to the database tables that
are uses to record information about topics and posts. It also requires
the creation of a new table to record information about why posts have
been hidden.

Too update the database carry out the following steps.

#. Log into the PostgreSQL database used GroupServer by using the
   following command::

     $ psql -Upgsql_user pgsql_dbname

   Note that ``pgsql_user`` and ``pgsql_dbname`` are the database user
   and database name that was setup during installation. Both can be
   found in the ``instance.cfg`` file in the installation directory
   of GroupServer.

#. Run the following SQL to update the post and topic tables::

     ALTER TABLE topic ADD COLUMN hidden TIMESTAMP WITH TIME ZONE;
     ALTER TABLE post ADD COLUMN hidden TIMESTAMP WITH TIME ZONE;

#. Finally, create the hidden post table by running the following SQL
   commands::

     CREATE TABLE hidden_post (
       post_id       TEXT REFERENCES post ON UPDATE CASCADE,
       date_hidden   TIMESTAMP WITH TIME ZONE NOT NULL,
       hiding_user   TEXT NOT NULL,
       reason        TEXT
     );
     CREATE UNIQUE INDEX hidden_post_pkey
       ON hidden_post
       USING BTREE(post_id, date_hidden);

Update the Packages
~~~~~~~~~~~~~~~~~~~

Carry out the following steps to update the package versions.

#. Download the Pineapple Snow tar-ball from `the GroupServer download
   page <http://groupserver.org/downloads>`_

#. Uncompress the tar-ball.

#. Copy the file ``groupserver-11.04/versions.cfg`` to your existing
   GroupServer installation.

#. In your existing GroupServer installation run::

      $ ./bin/buildout -N

.. [#HideAPost] The new Hide a Post interface closes `Ticket 316
   <https://redmine.iopen.net/issues/316>`_ and many minor
   tickets that were related to hiding a post.
.. [#FullAddress] Support a full email address closes `Ticket 445
   <https://redmine.iopen.net/issues/445>`_.
.. [#LogTabs] Switching the *Join and Leave Log* to use tabs from
   jQuery.UI closes `Ticket 641
   <https://redmine.iopen.net/issues/641>`_.
.. [#ViewLink] Fixing the issue with the *view* link closes `Ticket 642
   <https://redmine.iopen.net/issues/642>`_.
.. [#EmailSettings] Fixing the coding error on with the *Change Email
    Settings* page closes `Ticket 660
    <https://redmine.iopen.net/issues/660>`_
.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.Net: https://onlinegroups.net/
.. _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
   http://creativecommons.org/licenses/by-sa/3.0/nz/
