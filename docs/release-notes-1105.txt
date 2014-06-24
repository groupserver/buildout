------------------------------------------------------
GroupServer 11.05 — Eskimo Pie with Middle Class Guilt
------------------------------------------------------

:Authors: Michael JasonSmith; Richard Waid; Dan Randow
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2011-05-27
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

The main update to GroupServer that is present in the Eskimo Pie
release is the new `request membership`_ system. However there
are other `minor fixes`_ that have been made. You can `get Eskimo
Pie`_ immediately. Work is now starting on GroupServer 11.06 —
Soft Serve from Mr Whippy.

Request Membership
==================

The Request Membership system [#RequestMembership]_ allows someone
to request membership of a private group. The group administrator is
informed of the request by email. The administrator can then accept
or decline the request using a Web interface. Effectively the Request
Membership system works like the system that is used to invite people
to join groups, but in reverse.

Minor Fixes
===========

Minor fixes in Eskimo Pie include the following. 

* An update to the Start a Group system so the system administrator is 
  made the group administrator [#StartAGroup]_.
* When an email address is verified it is made the preferred delivery 
  address if the user has no other preferred delivery addresses
  [#Verify]_.
* The list of files that are associated with a post are more clearly 
  demarcated from the body of the message [#Files]_.
* Long URLs no longer word-wrap in the body of posts [#URLs]_.
* Zope has been updated to 2.3.6 [#Zope]_. This *may* cause problems
  with some configurations, as IPv6 support is now present.

Get Eskimo Pie
==============

To get Eskimo Pie go to `the Downloads page for GroupServer
<http://groupserver.org/downloads>`_ and follow `the GroupServer
Installation documentation <http://groupserver.org/downloads/install>`_.

Those who already have a functioning installation can `update an existing
GroupServer system`_.

Update an Existing GroupServer System
-------------------------------------

To upgrade an existing GroupServer system to Eskimo Pie you must first
`update the database`_ and then `update the packages`_.

Update the Database
~~~~~~~~~~~~~~~~~~~

The `Request Membership`_ update requires the creation of a new table
to record information about membership requests. To update the database
carry out the following steps.

#. Log into the PostgreSQL database used GroupServer by using the
   following command::

     $ psql -Upgsql_user pgsql_dbname  

   Note that ``pgsql_user`` and ``pgsql_dbname`` are the database user
   and database name that was setup during installation. Both can be
   found in the ``instance.cfg`` file in the installation directory
   of GroupServer.
   
#. Run the following SQL to create the request membership table::

     CREATE TABLE user_group_member_request (
       request_id          TEXT                      PRIMARY KEY,
       user_id             TEXT                      NOT NULL,
       site_id             TEXT                      NOT NULL,
       group_id            TEXT                      NOT NULL,
       request_date        TIMESTAMP WITH TIME ZONE  NOT NULL,
       message             TEXT,
       responding_user_id  TEXT,
       response_date       TIMESTAMP WITH TIME ZONE,
       accepted            BOOLEAN
     );

Update the Packages
~~~~~~~~~~~~~~~~~~~

Carry out the following steps to update the package versions.

#. Download the Eskimo Pie tar-ball from `the GroupServer download 
   page <http://groupserver.org/downloads>`_

#. Uncompress the tar-ball.
   
#. Copy the file ``groupserver-11.05/versions.cfg`` to your existing
   GroupServer installation.
   
#. Copy the file ``groupserver-11.05/buildout.cfg`` to your existing
   GroupServer installation.

#. In your existing GroupServer installation run::

      $ ./bin/buildout

.. [#RequestMembership] Adding the Request Membership system (finally) 
   closes `Ticket 49. <https://redmine.iopen.net/issues/49>`_
   More information in the Request Membership system can be found in
   `the Request Membership topic.
   <http://groupserver.org/r/topic/1JdMOAD7VrlwnN7MQcgNhi>`_
.. [#StartAGroup] Setting the group administrator when the group is 
   started closes `Ticket 611.
   <https://redmine.iopen.net/issues/611>`_
.. [#Verify] Setting the verified address as the preferred delivery 
   address closes `Ticket 661.
   <https://redmine.iopen.net/issues/661>`_
.. [#Files] Enhancing the file notification area closes `Ticket 664
   <https://redmine.iopen.net/issues/664>`_
.. [#URLs] Fixing the URLs so the do not break over multiple lines 
   closes `Ticket 671.
   <https://redmine.iopen.net/issues/671>`_
.. [#Zope] Updating to Zope 2.3.6 is something I am sure to regret, 
   because it has the potential to make GroupServer installation even 
   more tricky than before. However, it is done, and I have closed
   `Ticket 672.
   <https://redmine.iopen.net/issues/672>`_
.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.Net: https://onlinegroups.net/
.. _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
   http://creativecommons.org/licenses/by-sa/3.0/nz/

