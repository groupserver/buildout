===============================================
GroupServer 14.03 — Ouzo utilised as an unguent
===============================================

:Authors: `Michael JasonSmith`_; `Bill Bushey`_; `Dan Randow`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2014-03-20
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

.. highlight:: console

------------
Introduction
------------

It has been seventeen months since the last release of GroupServer
(Absinthe, 12.11). The major delay was caused by the creation of a new
user-interface for GroupServer. Almost all the `changes to GroupServer`_
are user-visible — and include a new notifications, and updated systems for
adding people. You can `get Ouzo`_ immediately.

----------------------
Changes to GroupServer
----------------------

The most significant change to GroupServer in the Ouzo release is the `new
style pages`_. In addition the system for `adding people`_ in bulk has been
completely rewritten, there has been an extensive `notifications update`_,
and `other updates`_.

.. index:: 
   single: Skin
   pair: JavaScript; Bootstrap

New style pages
===============

The main update to GroupServer has been the implementation of new pages on
the Web interface (`Issue 3423`_). The navigation_ has been extensively
reworked: there is an `updated layout`_ for most pages, and pages have been
integrated with `Twitter Bootstrap`_ [#css]_. The `profile images`_ are now
(mostly) square, with new code to improve their performance. In addition
the pages have been made more responsive_, and the performance_ of the
pages has been improved.

:Acknowledgements:

  The pages were redesigned by Mike Harding from Cactuslab_, to whom all
  praise should be given.

.. _issue 3423: https://redmine.iopen.net/issues/3423
.. _Cactuslab: http://cactuslab.com/

Navigation
----------

The navigation scheme for GroupServer has changed dramatically in this
release, moving away from the context-menu (along the left), and dropping
the site-menu (along the top) entirely. In their place is a system based on
breadcrumbs (`Issue 3510`_).

The *Profile* page is the only page left that makes use of the
context-menu.

.. _Issue 3510: https://redmine.iopen.net/issues/3510

Updated layout
--------------

The *Group* page [#group]_ and *Site* homepage [#site]_ have been updated
so they have asymmetric columns — with less important information placed in
the smaller column on the right. Both make use of `Twitter Bootstrap`_, the
updated `profile images`_, and the `updated lists`_.

The *Group* page gets an updated *About* area, and *Change about* page
(`Issue 3871`_). The *Site* homepage gets a new *Welcome* area (`Issue
3869`_) in addition to an updated *Introduction* (`Issue 3870`_).

The layout of the *Topic* page and *Post* page have been updated to move
the metadata (such as who posted the message, and when) to the left of the
post (`Issue 3455`_).

The *Image* page, which displays an image that has been posted to a group,
has been updated to reflect the layout of the *Topic* page. Problems with
SVG images have also been resolved (`Issue 3663`_).

Most of the other pages have been updated to take `Twitter Bootstrap`_ and
the new navigation_ into account.

.. _Issue 3869: https://redmine.iopen.net/issues/3869
.. _Issue 3870: https://redmine.iopen.net/issues/3870
.. _Issue 3871: https://redmine.iopen.net/issues/3871
.. _Issue 3455: https://redmine.iopen.net/issues/3455
.. _Issue 3663: https://redmine.iopen.net/issues/3663

.. index::
   pair: JavaScript; Bootstrap

Twitter Bootstrap
-----------------

The GroupServer user-interface is now based on `Twitter Bootstrap
2.3`_. The look of every single page has changed significantly as a
consequence.

The tabs, on the Group page and Site page, have dropped the use of
jQuery.UI tabs in favour of the Bootstrap Tabs. The Popover class is used
to show information including the privacy of a group and posts,
encouragement for the new administrator, and the Share widget.

.. _Twitter Bootstrap 2.3: http://getbootstrap.com/2.3.2/

Profile images
--------------

Another major change has been with the profile images. They are now shown
in more places and at `multiple resolutions`_. In addition most of the
images are square_. If a group member has not set an image a *missing
profile image* image is shown.

Multiple resolutions
~~~~~~~~~~~~~~~~~~~~

The profile-images in releases of GroupServer prior to Ouzo were restricted
to 81×108 pixels. Now the content provider [#image]_ is able to supply profile
images at a range of resolutions (`Issue 588`_). In addition the `image
compression`_ enhancements have also been rolled out to the profile image,
so small images are now directly embedded into the page.

.. _Issue 588: https://redmine.iopen.net/issues/588

Square
~~~~~~

The profile images are now square by default [#square]_. These square
images are shown in more places, such as in the new *Recently active* list
on the *Group* page (`Issue 3873`_), the *Profile* link at the top of every
page, and the *Post message* area of the *Topic* and *Start topic* pages.

.. _Issue 3873: https://redmine.iopen.net/issues/3873

Updated lists
-------------

At its core GroupServer provides lists of things: groups, topics, posts,
files, and people. All these lists have been updated to improve the
hierarchy of information.

* The *Groups* list on the *Site* page now lists all the visible groups,
  making the *Groups* page redundant (`Issue 3449`_).

* The *Files* icons for a topic are no-longer shown by default. Instead a
  single attachment-icon is shown, and icons for the files are displayed in
  a tooltip.

* Who made the most recent post, and when, is more prominently displayed.

* The topic-keywords are labelled ``Keywords``.

* There is a new list of *Recently active* members on the *Group page*,
  which is loaded through AJAX (`Issue 3873`_).

* The list of *Files* has been moved to the secondary column of the *Group*
  page, from the main area.

.. _Issue 3449: https://redmine.iopen.net/issues/3449

Responsive
----------

The GroupServer web pages are now more responsive to the size of device
(`Issue 3909`_). This allows the pages to look good from screens found on
desktops, down to small feature phones. This allows people to keep up with
conversations anywhere and any time. Some pages, such as the Image page
(`Issue 3508`_) have had particular attention to ensure the page works well
at multiple sizes.

.. _Issue 3508: https://redmine.iopen.net/issues/3508
.. _Issue 3909: https://redmine.iopen.net/issues/3909

Performance
-----------

The performance Web interface has been massively improved. The primary way
of doing this has been with `refactored JavaScript`_. In addition `image
compression`_ has been increased and `font icons`_ introduced. Finally,
many small changes have been made to the layout of the pages to reduce the
*time to glass.*

Refactored JavaScript
~~~~~~~~~~~~~~~~~~~~~

All the JavaScript used by GroupServer has been refactored into separate
modules (`Issue 344`_). This makes documentation and maintenance far
easier, at the expense of speed. To compensate, all JavaScript (including
that supplied by jQuery [#jquery]_ and Twitter Bootstrap [#bootstrap]_) is
deferred until after the paged has been shown [#layout]_. In addition, all
the JavaScript has been *minified* to reduce the amount of data that is
transported, and to speed the parsing by the Web browser. Finally, almost
all the JavaScript is *asynchronously* loaded [#async]_.

The JavaScript code loads and assists with navigating the lists of recent
topics, posts and files. This code has been refactored so the all the lists
share the same code (`Issue 3507`_). In addition the lists are only loaded
when the corresponding tab is visible. Combined this greatly reduces the
number of requests required to load the page.

`Strict mode`_ has been enabled for all the core JavaScript modules, and
some of the other modules. This has the combined effect of reducing the
number of errors, and improving performance by allowing the browser to
optimise the code.

.. _Issue 344: https://redmine.iopen.net/issues/344
.. _Issue 3507: https://redmine.iopen.net/issues/3507
.. _Strict mode: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions_and_function_scope/Strict_mode

Image compression
~~~~~~~~~~~~~~~~~

Many JPEG images that are posted by group members have very low compression
(or very high quality, depending how you like to look at it). GroupServer
now produces thumbnails with aggressive compression by default (`Issue
663`_). As the dimensions of the image are reduced the quality of the image
is also dropped — making the images far smaller [#compress]_. When images
are *particularly* small a data-URI is used to directly embed the image
into the page, reducing the need to make an HTTP request to fetch the
image.

.. _Issue 663: https://redmine.iopen.net/issues/663

Font icons
~~~~~~~~~~

The new user-interface uses a font to provide the different icons in the
interface (`Issue 3788`_). These are quick to load and render. In addition
they are independent of the resolution of the device, so work well in the
new responsive_ user interface.

.. _Issue 3788: https://redmine.iopen.net/issues/3788

Adding people
=============

The system for adding people to a group has undergone many improvements,
primarily to the pages that allow the new member details to be uploaded by
CSV, but also to the system that allows existing site members to be invited
to join a group.

The systems for inviting people in bulk [#inviteCSV]_ — and adding people
in bulk [#addCSV]_ — using a CSV file have been completely rewritten
(`Issue 3494`_). Both systems now use AJAX and JSON to parse the CSV file,
and invite [#inviteJSON]_ or add [#addJSON]_ individual people. This,
combined with widgets provided by `Twitter Bootstrap`_, allows for
continual progress updates, avoids server timeouts, and is **massively**
more usable.

On a more minor note, the page for inviting site members to join a group
has been enhanced with the addition of email-addresses, which helps
distinguish between people with similar names (`Issue 452`_).

.. _Issue 3494: https://redmine.iopen.net/issues/3494
.. _Issue 452: https://redmine.iopen.net/issues/452

.. index:: Notification

Notifications update
====================

Most of the notifications in GroupServer have been updated in Ouzo (`Issue
3892`_). Premailer_ is now used to embed CSS into the HTML-formatted
messages. The CSS itself is specified using a system of "skins" that is
very similar to what is used for the Web pages [#emailCSS]_, and the
default look is very similar to the Web user interface [#emailLayout]_.

Almost all the notifications have been moved to the file-system — rather
than requiring templates in the ZMI (`Issue 269`_) — and the use of the new
notifications is now far more consistent than before.

.. _Issue 3892: https://redmine.iopen.net/issues/3892
.. _Premailer: https://pypi.python.org/pypi/premailer/
.. _Issue 269: https://redmine.iopen.net/issues/269

.. index::
   pair: Notification; Topic digest

Topic digests
-------------

The system for producing the topic digests [#digests]_ has been completely
rewritten (`Issue 408`_). The digest email is provided in both HTML and
plain-text formats. In addition the code for sending the digests
[#sendDigest]_ has been rewritten, so it uses less memory, and is more
secure (`Issue 3415`_ and `Issue 3417`_).

.. _Issue 408: https://redmine.iopen.net/issues/408
.. _Issue 3415: https://redmine.iopen.net/issues/3415
.. _Issue 3417: https://redmine.iopen.net/issues/3417

Other updates
=============

As well as the major rewrite of the user-interface a number of smaller
changes have been made with the Ouzo release that makes GroupServer more
useful, more usable, and easier to maintain.

Autocomplete with *Start a topic*:
    The *Start a topic* page [#start]_ now has type-ahead (provided by
    `Twitter Bootstrap`_) that suggests the names of existing topics in the
    group (`Issue 282`_).

.. _Issue 282: https://redmine.iopen.net/issues/282

Show password:
    All password entries (for login and setting a password) now have a
    toggle to allow a group member to hide his or her password in public
    places (`Issue 519`_) [#password]_.

.. _Issue 519: https://redmine.iopen.net/issues/519

Attachment detection:
    The code for determining the attachments to show, and the attachments
    to hide, has been rewritten to allow more attachments through (`Issue
    4073`_).

.. _Issue 4073: https://redmine.iopen.net/issues/4073

*Join and leave log*:
    The *Join and leave log* has been moved to the *Members* page (`Issue
    3683`_).

.. _Issue 3683: https://redmine.iopen.net/issues/3863

.. index::
   pair: JavaScript; WYMeditor
   pair: JavaScript; jQuery

*WMYeditor* updated:
  The *WYMeditor* is used to provide editing of HTML content such as the
  *About* area in a group. It has been updated to work with jQuery 1.9
  (`Issue 3868`_).

.. _Issue 3868: https://redmine.iopen.net/issues/3868

Keywords on the *Topic* page:
    Keywords, summarising what has been discussed, are now shown at the top
    of the *Topic* page (`Issue 877`_)

.. _Issue 877: https://redmine.iopen.net/issues/877

Privacy on the *Group* page:
    The privacy setting for a group is shown on the *Group* page, near the
    email address for the group (`Issue 3914`_).

.. _Issue 3914: https://redmine.iopen.net/issues/3914

Accessibility:
    WAI-ARIA attributes have been added throughout GroupServer to improve
    the accessibility.

Python 3 updates:
    The slow journey to convert GroupServer from Python 2 to Python 3 has
    been started. At this stage three sets of changes have been made, or
    are being made:

    * Ensuring the code is consistent with PEP-8_,
    * Switching to Unicode literals where possible (PEP-3112_), and
    * Switching to absolute import (PEP-328_).

.. _PEP-8: http://legacy.python.org/dev/peps/pep-0008/
.. _PEP-3112: http://legacy.python.org/dev/peps/pep-3112/
.. _PEP-328: http://legacy.python.org/dev/peps/pep-0328/

--------
Get Ouzo
--------

To get Ouzo go to `the Downloads page for GroupServer`_ and follow `the
GroupServer Installation documentation`_. Those who already have a
functioning installation can `update an existing GroupServer system`_.

..  _The Downloads page for GroupServer: http://groupserver.org/downloads
..  _The GroupServer Installation documentation:

Update an Existing GroupServer System
=====================================

To update a system running the Absinthe release of GroupServer (12.11) to
Ouzo (14.03) carry out the following steps.

#.  Download the Ouzo tar-ball from `the GroupServer download page
    <http://groupserver.org/downloads>`_.

#.  Uncompress the tar-ball::

      $ tar cfz groupserver-14.03.tar.gz

#.  Change to the directory that contains your existing GroupServer
    installation.

#.  Make a backup of your custom configuration::

      $ cp custom.cfg custom-bk.cfg
      $ cp config.cfg config-bk.cfg

#.  Copy the new configuration files to your existing GroupServer
    installation::

      $ cp ../groupserver-14.03/*.cfg .

#.  Restore your custom configuration::

      $ mv custom-bk.cfg custom.cfg
      $ mv config-bk.cfg config.cfg

#.  In your existing GroupServer installation run::

      $ ./bin/buildout -n

#.  Restart your GroupServer instance.

---------
Resources
---------

- Code repository: https://source.iopen.net/groupserver/
- Questions and comments to http://groupserver.org/groups/development
- Report bugs at https://redmine.iopen.net/projects/groupserver

.. [#css] The product for supplying the CSS is located at
          <https://source.iopen.net/groupserver/gs.content.js.bootstrap>
.. [#group] The code responsible for laying out the *Group* page is
          provided by <https://source.iopen.net/groupserver/gs.group.home>
.. [#site] The code responsible for laying out the *Site* homepage is
          provided by <https://source.iopen.net/groupserver/gs.site.home>
.. [#image] The product for supplying the profile-image content provider is
            located at
            <https://source.iopen.net/groupserver/gs.profile.image.base>
.. [#square] The product for supplying the square profile-image is located at
             <https://source.iopen.net/groupserver/gs.profile.image.square>
.. [#jquery] The product for supplying the jQuery JavaScript is located at
             <https://source.iopen.net/groupserver/gs.content.js.jquery.base>
.. [#bootstrap] The product for supplying the Twitter Bootstrap code is
                located at
                <https://source.iopen.net/groupserver/gs.content.js.bootstrap>
.. [#layout] The product for determining what JavaScript is loaded, and
             how, is provided by
             <https://source.iopen.net/groupserver/gs.content.layout>
.. [#async] The code for asynchronously loading the JavaScript is provided
            by <https://source.iopen.net/groupserver/gs.content.js.loader/>
.. [#compress] The code for determining how images should be displayed is
               provided by
               <https://source.iopen.net/groupserver/gs.image>
.. [#inviteCSV] The code for inviting people by uploading a CSV file is
                provided by
                <https://source.iopen.net/groupserver/gs.group.member.invite.csv>
.. [#addCSV] The code for adding people by uploading a CSV file is provided
             by
             <https://source.iopen.net/groupserver/gs.group.member.add.csv>
.. [#inviteJSON] The code for inviting someone by JSON is provided by
                 <https://source.iopen.net/groupserver/gs.group.member.invite.json>
.. [#addJSON] The code for adding someone by JSON is provided by
              <https://source.iopen.net/groupserver/gs.group.member.add.json>

.. [#emailCSS] The code for specifying the CSS for the HTML-formatted
              notifications is provided by
              <https://source.iopen.net/groupserver/gs.content.email.css>

.. [#emailLayout] The code for specifying the layout of the messages is
                  provided by
                  <https://source.iopen.net/groupserver/gs.content.email.layout>
.. [#digests] The system for generating the topic digests is provided by
              <https://source.iopen.net/groupserver/gs.group.messages.topicsdigest>

.. [#sendDigest] The system for sending the topic digests is provided by
                  <https://source.iopen.net/groupserver/gs.group.messages.senddigest>

.. [#start] The *Start a topic* page is provided by
            <https://source.iopen.net/groupserver/gs.group.messages.starttopic>

.. [#password] The toggle to show or hide a password is provided by
            <https://source.iopen.net/groupserver/gs.profile.password>


..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Creative Commons Attribution-Share Alike 4.0 International License:
    http://creativecommons.org/licenses/by-sa/4.0/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Dan Randow: http://groupserver.org/p/danr
..  _Bill Bushey: http://groupserver.org/p/wbushey
..  _E-Democracy.org: http://forums.e-democracy.org/

..  LocalWords:  refactored iopen JPEG redmine jQuery jquery async
