--------------------------------------------------------
GroupServer 11.07 — Frozen Yoghurt Accompanied by Carols
--------------------------------------------------------

:Authors: `Michael JasonSmith`_; `Richard Waid`_; `Dan Randow`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2011-07-28
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

Introduction
============

The main update that is present in the Frozen Yoghurt release of
GroupServer is a `new stylesheet`_ for devices with narrow
displays . There is also a new converter for `HTML-formatted
messages`_. In addition a number of `minor fixes`_ are part of
this release. You can `get Frozen Yoghurt`_ immediately. Work is
now starting on GroupServer 11.08 — Banana Split Eaten in a
Comfortable Silence.

Acknowledgements
----------------

Thanks to `Steven Clift`_ for his support with the `new stylesheet`_.
Thanks also to `Le Coyote`_ and `Alice Rose`_ for testing an early
release of Frozen Yoghurt.

New Stylesheet
==============

Devices with narrow displays, such as mobile phones and tablets, now have
a dedicated stylesheet [#NewCSS]_. The system uses `CSS3 Media Queries`_
to reformat the page when the browser window is narrow. Pages that have
been specifically optimised for small-screen devices include

* The site homepage, 
* The group page, 
* The topic page and 
* The image page. 

Many other pages work on small screens, including the post page and
the topics page.

HTML-Formatted Messages
=======================

Email messages can be in multiple formats, including plain text and
HTML. Sometimes email messages are formatted using just HTML. When
this occurs GroupServer converts the HTML version of the message into
a plain-text version. It is this plain-text version of the post that
is displayed on the Web pages. The code that converts the HTML-message
into plain-text has been updated [#Converter]_. The updated code uses
`the standard Python HTML Parser library`_ to parse the message, and
also handles URLs better.

Minor Fixes
===========

Minor fixes in Frozen Yoghurt include the following.

* The position of the Sticky form in a topic has been moved, so it is
  visible when there is only one post [#Sticky]_.
  
* Files that are part of hidden posts are hidden from the index of files
  at the top of the topic [#Hidden]_. (Files that were part of hidden
  posts were never able to be viewed.)

* A new configuration system for GroupServer is present, but not used. 
  The ``gs.option`` product is part of an ongoing effort to move more
  data out of the ZODB and into the `PostgreSQL`_ relational database.
  The ``README`` in the base of the ``gs.option`` product has more
  details.

* An error with the Can Post code was fixed.

* The word *Home* has been dropped from the group page, as it added
  nothing and took up valuable space (which was especially noticeable
  with the `new stylesheet`_).

Get Frozen Yoghurt
==================

To get Frozen Yoghurt go to `the Downloads page for GroupServer`_ and
follow `the GroupServer Installation documentation`_. Those who already
have a functioning installation can `update an existing GroupServer
system`_.


Update an Existing GroupServer System
-------------------------------------

To update an existing GroupServer system to Frozen Yoghurt you must
`update the database`_ and then `update the packages`_.

Update the Database
~~~~~~~~~~~~~~~~~~~

The new ``options`` code requires the creation of a new table to record
information about the properties of the various parts of GroupServer (see
`Minor Fixes`_). To update the database carry out the following steps.

#. Log into the PostgreSQL database used GroupServer by using the
   following command::

     $ psql -Upgsql_user pgsql_dbname  

   Note that ``pgsql_user`` and ``pgsql_dbname`` are the database user
   and database name that were set during installation. Both can be
   found in the ``instance.cfg`` file in the installation directory
   of GroupServer.
   
#. Run the following SQL to create the ``options`` table::

    CREATE TABLE option (
        component_id      TEXT  NOT NULL,
        option_id         TEXT  NOT NULL,
        site_id           TEXT  NOT NULL,
        group_id          TEXT  NOT NULL,
        value             TEXT
    );

    CREATE UNIQUE INDEX option_idx 
    ON option (component_id, option_id, site_id, group_id);

.. index::
   pair: Install; Bootstrap

Update the Packages
~~~~~~~~~~~~~~~~~~~

To upgrade the pages in an existing GroupServer system to Frozen Yoghurt
carry out the following steps.

#.  Download the Frozen Yoghurt tar-ball from `the GroupServer download 
    page <http://groupserver.org/downloads>`_.

#.  Uncompress the tar-ball.
   
#.  Copy the file ``groupserver-11.07/versions.cfg`` to your existing
    GroupServer installation.
   
#.  Copy the file ``groupserver-11.07/buildout.cfg`` to your existing
    GroupServer installation.

#.  In your existing GroupServer installation run::

      $ ./bin/easy_install -U setuptools && ./bin/python bootstrap.py 
      $ ./bin/buildout

    The ``setuptools`` have to be updated, and ``bootstrap.py`` rerun,
    because the version of Zope used by GroupServer has undergone an
    update.

.. [#NewCSS] The new mobile CSS closes `Ticket 444 
    <https://redmine.iopen.net/issues/444>`_. More 
    information on the mobile stylesheet can be found in `the topic in 
    GroupServer Development
    <http://groupserver.org/r/topic/2zZBPuapfn1wu9J6LgVCX>`_.

..  [#Converter] Updating the converter closes 
    `Ticket 596 <https://redmine.iopen.net/issues/596>`_.

..  [#Sticky] Fixing the position of the Sticky form in a topic closes
    `Ticket 705 <https://redmine.iopen.net/issues/705>`_.

..  [#Hidden] Hiding posts that are part of hidden files closes 
    `Ticket 692 <https://redmine.iopen.net/issues/692>`_.

..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
    http://creativecommons.org/licenses/by-sa/3.0/nz/
.. _Michael JasonSmith: http://groupserver.org/p/mpj17
.. _Richard Waid: http://groupserver.org/p/richard
.. _Dan Randow: http://groupserver.org/p/danr
..  _Steven Clift: http://groupserver.org/p/stevenc
..  _Le Coyote: http://groupserver.org/p/5wdOKPGCaEV8sDPbmN0Qnn
..  _Alice Rose: https://twitter.com/heldinz
..  _CSS3 Media Queries: http://www.w3.org/TR/css3-mediaqueries/
..  _The standard Python HTML Parser library: 
    https://docs.python.org/2/library/htmlparser.html
..  _PostgreSQL: http://www.postgresql.org/
..  _The Downloads page for GroupServer: http://groupserver.org/downloads
..  _The GroupServer Installation documentation: 
    http://groupserver.org/downloads/install

