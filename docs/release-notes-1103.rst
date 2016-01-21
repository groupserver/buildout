-----------------------------------------------------
GroupServer 11.03 — Pineapple Snow at a Child's Party
-----------------------------------------------------

:Authors: Michael JasonSmith; Richard Waid; Alice Rose; Dan Randow
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2011-03-29
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

The Pineapple Snow release of GroupServer contains four main enhancements
and corrections.

* There is an `Updated Change Email Settings Page`_.
* Searching will now search the topic and post titles [#SearchIssue]_.
* An *Edit this page* link is sometimes shown to logged out users on
  editable pages [#Edit]_.
* The *Accept Invitation* page looks a lot better [#Accept]_.

You can `get Pineapple Snow`_ immediately. Work is now starting on
GroupServer 11.04 — Slushy followed by a Pounding Headache.

.. index::
   single: Profile
   pair: Email; Settings
   pair: JavaScript; jQuery
   pair: JavaScript; jQuery.UI

Updated Change Email Settings Page
==================================

The Change Email Settings page has had an extensive redesign
[#Redesign]_. Email addresses can be dragged from one list to another
in order to characterise them. The old interface relied on menus and
multiple buttons, and was far harder to use. In addition the new
interface automatically updates when an email address is verified
[#Verify]_.

The new interface uses the jQuery.UI JavaScript library, just like the
group homepage. jQuery.UI is an excellent library builds on the already
great jQuery library [#jQuery]_.

Get Pineapple Snow
==================

To get Pineapple Snow go to `the Downloads page for GroupServer
<http://groupserver.org/downloads>`_ and follow `the GroupServer
Installation documentation <http://groupserver.org/downloads/install>`_.

Those who already have a functioning installation can `update an existing
GroupServer system`_.

Update an Existing GroupServer System
-------------------------------------

Carry out the following steps to update the package versions.

#. Download the Pineapple Snow tar-ball from `the GroupServer download 
   page <http://groupserver.org/downloads>`_

#. Uncompress the tar-ball.
   
#. Copy the file ``groupserver-11.03/versions.cfg`` to your existing
   GroupServer installation.
   
#. In your existing GroupServer installation run::

      $ ./bin/buildout -N

.. [#SearchIssue] Updating search closes `Ticket 227
   <https://redmine.iopen.net/issues/227>`_
.. [#Edit] The *Edit this page* link is only shown to the Anonymous
   user if logged in members can edit the page. Showing this link closes
   `Ticket 384 <https://redmine.iopen.net/issues/384>`_
.. [#Accept] The *Accept Invitiation* was hit
    by a CSS error. Fixing the error closes `Ticket 618
    <https://redmine.iopen.net/issues/618>`_ and fixes a
    related error on other pages with radio buttons and check buttons.
.. [#Redesign] The redesign of the *Change Email Settings* page closes
   `Ticket 478 <https://redmine.iopen.net/issues/478>`_ and
   `Ticket 472 <https://redmine.iopen.net/issues/472>`_. The
   `topic in GroupServer Development
   <http://groupserver.org/r/topic/4yFQxAsa4ge4zc0c8k4svn>`_  details
   the new design.
.. [#Verify] Automatically updating the *Change Email
   Settings* page when an address is verified closes `Ticket 276
   <https://redmine.iopen.net/issues/276>`_.
.. [#jQuery] The new *Change Email Settings* page uses `the sortable
   widgets <http://jqueryui.com/sortable/>`_ and the `dialog
   widget <http://jqueryui.com/dialog/>`_ from jQuery UI.
.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.Net: https://onlinegroups.net/
.. _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
   http://creativecommons.org/licenses/by-sa/3.0/nz/

