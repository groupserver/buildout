---------------------------------------------------
GroupServer 10.10 — Gelato while Viewing the Sights
---------------------------------------------------

:Authors: Michael JasonSmith; Richard Waid; Alice Rose; Dan Randow
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2010-10-26
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

The changes below form the bulk of what is new in the Gelato release of
GroupServer. Work is now progressing on GroupServer
10.11 — Kulfi Craved while Caving.

New Group Homepage
==================

The homepage used by groups has had a major redesign [#GroupHome]_. Now
it is divided into multiple tabs. This allows for information to be
better organized, and more easily found. Overall the look is cleaner,
and the page is easier to use.

Better Bouncing
===============

Sometimes an email to a group member will not get through, and the
message bounces.  GroupServer has always recorded these bounces. Now
this information is presented to the group administrator, who can see a
log of failed attempts to send the member an email message [#Bouncing]_.

Resend Invitation
=================

The group administrator now has the option of resending an invitation 
that did not get through to the new group member [#ResendInvite]_. There
have been many other minor improvements to the invitation system thanks
to the feedback from the users of `OnlineGroups.Net`_.

Notification Updates
====================

The email notifications that are sent out by GroupServer in response to
an event have been given a through update. They are now clearer and
contain more useful information than before [#Notifications]_.

New Favicon
===========

GroupServer now has a new multi-resolution favicon, which is shown in
the location bar of the browser [#Favicon]_.
 
New Help System
===============

The user manual and administration manuals are out of date and in
need of work. To help with this a new help system has been introduced
[#Manual]_. It allows for sections of the manuals to be more easily
maintained, which will hopefully allow for better manuals in the future.

Switch to Zope 2.13 Beta
========================

GroupServer now runs on the the latest version of `Zope 2`_. The new
features in Zope are used for the `new group homepage`_, and the `new
help system`_.

.. [#GroupHome] The details of the new group homepage is available in
   `the Group Homepage Rebuild topic in GroupServer Development.
   <http://groupserver.org/r/topic/1MqeURTRPJyYETkelmq1pk>`_ Deploying
   the new homepage closes `Ticket 426
   <https://redmine.iopen.net/issues/426>`_ and a slew of
   sub-tickets.

.. [#Bouncing] Showing a log of the failed attempts to send a message
   closes 
   
   * `Ticket 15!
     <https://redmine.iopen.net/issues/15>`_
   * `Ticket 509
     <https://redmine.iopen.net/issues/509>`_

.. [#ResendInvite] Allowing administrators to reissue an invitation
   closes
   `Ticket 489 <https://redmine.iopen.net/issues/489>`_

.. [#Notifications] Updating the notifications closes eight tickets

   * `Ticket 163 <https://redmine.iopen.net/issues/163>`_
   * `Ticket 215 <https://redmine.iopen.net/issues/215>`_
   * `Ticket 216 <https://redmine.iopen.net/issues/216>`_
   * `Ticket 221 <https://redmine.iopen.net/issues/221>`_
   * `Ticket 222 <https://redmine.iopen.net/issues/222>`_
   * `Ticket 223 <https://redmine.iopen.net/issues/223>`_
   * `Ticket 466 <https://redmine.iopen.net/issues/466>`_
   * `Ticket 513 <https://redmine.iopen.net/issues/513>`_

.. [#Favicon] Creating the new favicon for GroupServer closes 
   `Ticket 510 <https://redmine.iopen.net/issues/510>`_

.. [#Manual] Creating the new help pages closes 
   `Ticket 485 <https://redmine.iopen.net/issues/485>`_

.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.Net: https://onlinegroups.net/
.. _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
   http://creativecommons.org/licenses/by-sa/3.0/nz/
.. _GroupServer Development: http://groupserver.org/groups/development
.. _WYMeditor: http://www.wymeditor.org/
.. _Zope 2: http://zope2.zope.org/

