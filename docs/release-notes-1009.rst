-----------------------------------------------------------
GroupServer 10.09 —  Spaghettieis with a Wafer of Confusion
-----------------------------------------------------------

:Authors: Michael JasonSmith; Richard Waid; Alice Rose; Dan Randow
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2010-09-09
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

The changes below form the bulk of what is new in the
Spaghettieis release of GroupServer. Work is now progressing on
GroupServer 10.10 — Gelato while Viewing the Sights.

.. index::
   triple: Group; Member; Invite

Invitations
============

All the pages that deal with issuing and responding to invitations
have changed.

Issuing a Single Invitation
---------------------------

The biggest visible change with invitations is to the page used to issue
a single invitation. The administrator can write a **personal message**
to the invited member. The administrator can preview the message,
and preview the response page [#MessagePreview]_. Hopefully this will
encourage more invitations to be written, as they are less likely to
get marked as spam, and are more likely to get a response.

The **from address** of the invitation is now set to the address of the
administrator [#FromAddress]_. This will hopefully reduce the chances
of the invitation being caught in a spam filter even further.

The **email address** entry on the invitation page handles incorrect
data better, so only email addresses can be entered [#AddressEntry]_.
In the future I would like GroupServer to be more flexible with the
format of the addresses that are entered, but today is not that day [#FlexibleFormat]_.


Inviting Site Members
---------------------

The page for inviting  site members has been spruced up, but it has
not been overhauled in any major way. The **invitation message**
can now be changed. However, it cannot be previewed because I am lazy
and did not want to go through the hassle of writing a preview of the
Accept Invitation page for existing site members. If someone actually
uses Invite Site Members and bothers to write a ticket I may get some
motivation to write a preview page.


Inviting People In Bulk
-----------------------

The system for inviting people in bulk, by uploading a **CSV**, remains
much the same. Those who use the page a lot will notice some better
handling of required profile-attributes, but that is about it.
The **invitation message** cannot be changed when inviting people in
bulk [#CSVInvitation]_.

New Members Accepting Invitations
----------------------------------

The page used to accept invitations has undergone a major rewrite. The
mechanics (enter a password and join) stay the same. However, the
biography of the administrator who issued the invitation is now shown,
as well as some sample statistics about the group [#InvitationResponse]_.

New members are now sent a **welcome message** [#Welcome]_. Hopefully
new members will refer to the Welcome message when trying to get back
to the group homepage, rather than relying on the invitation. However,
if the new member does follow the invitation again he or she will be
shown a page that says that the invitation has been accepted, and to
the group homepage and *bookmark* it.

If an invitation is **declined** it is noted by the system
[#Declined]_. Sadly the unwanted profile is not deleted, due to an odd
issue with how Zope redirects. I plan to implement a system for removing
the unwanted profiles, but it will have to be a manual process for now
[#DeleteProfiles]_.

All **group administrators** will now get an email saying that a new
member has joined the group [#NewMemberEmail]_. If someone declines an
invitation then only the person who issued the invitation is informed.

Existing Members Accepting Invitations
--------------------------------------

The **profile page** now has a list of invitations on it
[#InviteList]_. Clicking on the invitation will go to the *Accept
Invitations* page.

The page that allows an existing site-member to accept or decline
invitations stays much as it was. It does gain the **group summary**
from the *Accept Invitation* page that is shown to new members. It also
shares the fixes to the notifications that are sent to the new member
and the group administrators.

.. index::
   triple: Group; Member; Join
   triple: Group; Member; Leave
   triple: Group; Member; Moderate

Join and Leave
==============

The pages that are by people to join a group without an invitation have
also changed.

Join and Sign Up
----------------

The *Join* and *Sign Up* pages superficially look exactly the same.
However, the code for joining a group is shared with the two *Accept
Invitations* pages, so the fixes to notifications are also shared. The
only specific improvement is a fix to prevent administrators who join
**moderated groups** from being moderated [#Moderation]_.

Leave
-----

The Leave page now presents some alternative ways of **reducing email
overload** [#LeaveAlt]_. The alternatives are going onto a **daily
digest** of topics, or to participate in the group using the **web
only**. We hope this will reduce the number of people who leave groups.

Join and Leave Log
------------------

People joining and leaving groups is now audited [#JoinAudit]_. The
audit-data is then fed into a new *Join and Leave Log* [#Log]_.

.. index::
   triple: Group; Member; Manage

Manage Members
==============

The Manage Members page looks much the same as it did. Those familiar
with the page will notice the **profile photos**, and a subtle rewording
of the text. For example, people who have been invited to join the group
are now clearly marked as such. Underneath the page has undergone a major
rewrite, thanks to the heroic efforts of Alice [#ManageMembers]_. The new
page now meshes properly with invitations, so invites can be withdrawn
without causing any problems [#WithdrawingInvites]_.

.. index::
   pair: JavaScript; WYMeditor

Change Site Introduction
========================

The page that is used to change the text that appears on the
homepage of the site has been updated so it uses the `WYMeditor`_
[#ChangeHomepage]_. This is the same JavaScript-based HTML editor that
is used to change a biography on the *Profile* of a member.

.. index:: Share link

Share Box
=========

The most visible change is to the topics and posts.
all the *Short link* links on the topics and posts pages to a
JavaScript-based **share box** [#ShareBox]_. The share box provides
a quick and easy way to share a post or topic on Facebook, Twitter,
or just as a URL.

.. [#MessagePreview] The `GroupServer Development`_ online group contains
   examples of

   * `The invitation-message preview
     <http://groupserver.org/r/img/1725-2010-04-14T073527Z>`_ and
   * `The response page
     <http://groupserver.org/r/img/2207-2010-04-23T073912Z>`_.

.. [#FromAddress] Setting the ``From`` address in invitations correctly
   will close `Ticket 290
   <https://redmine.iopen.net/issues/290>`_.

.. [#AddressEntry] Being strict about what can be entered as an email
   address fixes `Ticket 325
   <https://redmine.iopen.net/issues/325>`_. The fix also
   corrects the same error with the sign up page.

.. [#FlexibleFormat] More tolerant email address handling will hopefully
   come in `Baked Alaska
   <https://redmine.iopen.net/issues/445>`_.

.. [#CSVInvitation] `OnlineGroups.Net`_ could not ship an *Invite by CSV*
   page with an editable message as it is an invitation to spam
   people. However, we are not be averse to someone writing a page with
   an editable message and including that in GroupServer.

.. [#InvitationResponse] The `GroupServer Development`_ group contains
   `an example of the new Invitation Response page
   <http://groupserver.org/r/img/2207-2010-04-23T073912Z>`_.

.. [#Welcome] Sending a welcome message when joining a group will close
   `Ticket 303 <https://redmine.iopen.net/issues/303>`_.
   Previously new members only saw a welcome message when signing up
   or joining a group themselves. The same fix also removed `a rather
   nasty hack <https://redmine.iopen.net/issues/346>`_.

.. [#Declined] Logging the declined invitations closes `Ticket 278
   <https://redmine.iopen.net/issues/278>`_. It is also
   what allows people to be redurected if they follow invitations that
   have had a response. It will also add another entry in the ongoing
   saga “Why Physical Deletes are the Work of the Devil”.

.. [#DeleteProfiles] A simple Cron-job would probably be fine at cleaning
   up the unwanted profiles (see `Ticket 446
   <https://redmine.iopen.net/issues/446>`_).

.. [#NewMemberEmail] Telling all group administrators that a new
   member has joined a group will close `an irritating issue with
   GroupServer <https://redmine.iopen.net/issues/100>`_.

.. [#InviteList] Adding the list of invitations to the profile page
   will close `Ticket 347
   <https://redmine.iopen.net/issues/347>`_.

.. [#Moderation] Administrators being moderated only effects
   administrators of sites with moderated groups; regardless `Ticket
   235 <https://redmine.iopen.net/issues/235>`_ is closed.

.. [#JoinAudit] Auditing when people join and leave a group closes
   `Ticket 341 <https://redmine.iopen.net/issues/341>`_.

.. [#LeaveAlt] The alternatives to leaving are shown in `an example
   leave page <http://groupserver.org/r/img/7966-2010-07-08T142944Z>`_
   in the `GroupServer Development`_ group.

.. [#Log] The `GroupServer Development`_ group contains some
   examples of `what the *Join and Leave Log* looks like to different
   people <http://groupserver.org/r/post/74SlGaFBc9QORJDsGSgKrP>`_.
   Creating the log closes `Ticket 341
   <https://redmine.iopen.net/issues/341>`_.

.. [#ManageMembers] Neither `Ticket 420
   <https://redmine.iopen.net/issues/420>`_, `Ticket
   442 <https://redmine.iopen.net/issues/442>`_
   or `the appearance of the page
   <http://groupserver.org/r/img/8507-2010-07-26T054129Z>`_ convey what
   a monumental task it was to rewrite the Manage Members page. It is
   now a page that can be improved, rather than a huge hack.

.. [#WithdrawingInvites] It would be best if I kept hacks that *used*
   to exist around invitations to myself. Invitations
   now work well, closing `Ticket 435
   <https://redmine.iopen.net/issues/435>`_.

.. [#ChangeHomepage] The fix so the `WYMeditor`_ on the *Change the
   Site Introduction* page closes `Ticket 357
   <https://redmine.iopen.net/issues/357>`_.

.. [#ShareBox] Originally the share-box was slated for Pineapple Snow,
   but Richard completed the short-link improvements early on the
   request of a client, closing `Ticket 378
   <https://redmine.iopen.net/issues/378>`_.

.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.Net: https://onlinegroups.net/
.. _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
   http://creativecommons.org/licenses/by-sa/3.0/nz/
.. _GroupServer Development: http://groupserver.org/groups/development
.. _WYMeditor: http://www.wymeditor.org/
