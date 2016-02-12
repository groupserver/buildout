---------------------------------------------
GroupServer 11.06 — Soft Serve from Mr Whippy
---------------------------------------------

:Authors: `Michael JasonSmith`_; `Richard Waid`_; `Dan Randow`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2011-07-04
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

Introduction
============

The two main updates to GroupServer that are present in the Soft
Serve release are an update to the code that determines if
someone `can post`_, and a rebuild of the `site administration
pages`_.  In addition there are other `minor fixes`_ that have
been made. You can `get Soft Serve`_ immediately. Work is now
starting on GroupServer 11.07 — Frozen Yoghurt Accompanied by
Carols.

Acknowledgements
----------------

Thanks to `Le Coyote`_ and `DJS`_ for their very helpful suggestions,
and testing early releases of Soft Serve.

Can Post
========

When someone posts to a group the system checks to see if the user has
the correct permissions. The code that does this is known as the *can
post* code. In Soft Serve this code has undergone two main changes.

#.  Email addresses can be blocked from posting [#Blocking]_. This
    mechanism, known as blacklisting, extends the existing system that
    prevented addresses on the black-list from receiving posts. There
    is no user-interface for this system.
   
#.  The code has been moved to its own product [#CanPostMove]_.

Site Administration Pages
=========================

The site-administration pages did not work well. All the site
administration pages have been updated [#SiteAdmin]_. In particular,
the pages that allow an administrator to set the site timezone [#tz]_ and
change the site name [#SiteName]_ have been fixed so they work correctly.

.. index::
   pair: Email; Verify
   pair: Password; Rest
   triple: Group; Type; Announcement

Minor Fixes
===========

Minor fixes in Soft Serve include the following. 

* If a member with a single unverified address resets a password
  then that address will become verified [#Verify]_.
* The :mailheader:`Reply-to` address of an invitation is now set
  to the address of the administrator who issued the invitation
  [#ReplyTo]_.
* Only posting members of an *announcement* group are shown a
  link to start a topic [#StartTopic]_.
* The name of the initial GroupServer instance and GroupServer site have
  been changed [#GSName]_.
* A coding error with the *Members* page has been fixed
  [#PostingMembers]_.

Get Soft Serve
==============

To get Soft Serve go to `the Downloads page for GroupServer`_ and follow
`the GroupServer Installation documentation`_. Those who already have
a functioning installation can `update an existing GroupServer system`_.

Update an Existing GroupServer System
-------------------------------------

To upgrade an existing GroupServer system to Soft Serve you must first
`update the packages`_ and then `update the ZMI`_.

Update the Packages
~~~~~~~~~~~~~~~~~~~

Carry out the following steps to update the package versions.

#. Download the Soft Serve tar-ball from `the GroupServer download 
   page <http://groupserver.org/downloads>`_.

#. Uncompress the tar-ball.
   
#. Copy the file ``groupserver-11.06/versions.cfg`` to your existing
   GroupServer installation.
   
#. Copy the file ``groupserver-11.06/buildout.cfg`` to your existing
   GroupServer installation.

#. In your existing GroupServer installation run::

      $ ./bin/buildout

Update the ZMI
~~~~~~~~~~~~~~

The update to the `site administration pages`_ requires an instance
to be deleted from the Zope Management Interface (*ZMI*) before it will
work. To delete the instance carry out to the following tasks.

#.  Start GroupServer::
  
      $ ./bin/instance fg
    
#.  View the ZMI. If you did not change the defaults the ZMI can
    be accessed from <http://localhost:8080/manage/>.
    
#.  Enter the user-name and password of the ZMI administrator.
    
#.  Visit the ZMI page for the Example Site. This should be under
    ``example``, ``Content``, ``example_site``.
    
#.  Select the check-box next to ``admindivision (Administer Site)``.

#.  Click the Delete button. The ``adminidivision`` instance should
    be deleted.
    
After deleting the ``admindivision`` instance you should be able to view
the new site administration pages. To view these pages you must view
the homepage for your site and click on the link to administer the site.

Footnotes
=========

.. [#Blocking] Adding the code for blocking a post closed `Ticket 
   459 <https://redmine.iopen.net/issues/459>`_. This
   enhancement mostly helps Support groups, which otherwise lack a
   way to prevent people from posting.

.. [#CanPostMove] There is a long-running project to move code from the
   large ``Products`` eggs to many more smaller ``gs`` eggs. The move
   of the Can Post code to ``gs.group.member.canpost`` from the old
   ``Products.GSGroupMember`` is part of this. Moving the code closes
   `Ticket 423 <https://redmine.iopen.net/issues/423>`_. 

.. [#SiteAdmin] Updating the site administration pages closes 
   `Ticket 620 <https://redmine.iopen.net/issues/620>`_. 

.. [#tz] Updating the site-timezone page closes
   `Ticket 662 <https://redmine.iopen.net/issues/662>`_. 

.. [#SiteName] Updating the page that allows a site-name to be changed
   closes `Ticket 607
   <https://redmine.iopen.net/issues/607>`_.

.. [#Verify] Only the simple case of a single-address being verified 
   is currently handled. Verifying an email address when the password is
   reset closes
   `Ticket 480 <https://redmine.iopen.net/issues/480>`_.

.. [#ReplyTo] Prior to Soft Serve, the :mailheader:`Reply-to`
   address was set to the email address of the site
   support. Setting the :mailheader:`Reply-to` to the address of the
   administrator that issued the invitation closes `Ticket 681
   <https://redmine.iopen.net/issues/681>`_.

.. [#StartTopic] In an announcement group there is a distinction between
   group members that post (*posting members*) and members that just
   view posts (*normal members*). Prior to Soft Serve all group members
   saw the link on the homepage to the *Start a Topic* page. A normal
   member would see an error if he or she followed that link. Just
   showing the link on the homepage to the posting members closes
   `Ticket 530 <https://redmine.iopen.net/issues/530>`_.

.. [#GSName] Prior to Soft Serve the initial GroupServer instance,
   site and group had names that contained ``example``. Now
   the instance is called ``groupserver``, the initial site
   is called ``initial_site``, and the initial group is called
   ``example_group``. Renaming the instance and site `Ticket 690
   <https://redmine.iopen.net/issues/690>`_.

.. [#PostingMembers] Fixing the coding error on the Members page closes
   `Ticket 680 <https://redmine.iopen.net/issues/680>`_.

.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.Net: https://onlinegroups.net/
.. _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
   http://creativecommons.org/licenses/by-sa/3.0/nz/
.. _Michael JasonSmith: http://groupserver.org/p/mpj17
.. _Richard Waid: http://groupserver.org/p/richard
.. _Dan Randow: http://groupserver.org/p/danr
.. _Le Coyote: http://groupserver.org/p/5wdOKPGCaEV8sDPbmN0Qnn
.. _DJS: http://groupserver.org/p/2aHyPiiXulKwqIwXffSgBZ
.. _The Downloads page for GroupServer: http://groupserver.org/downloads
.. _The GroupServer Installation documentation: 
    http://groupserver.org/downloads/install

