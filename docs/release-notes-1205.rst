============================================================
GroupServer 12.05 — Faloodeh Consumed with an Eye on History
============================================================

:Authors: `Michael JasonSmith`_; `Richard Waid`_; `Dan Randow`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2012-05-02
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

Introduction
============

The `changes to GroupServer`_ in the Faloodeh release cover sites, 
groups and profiles — making them all more usable and extensible. You 
can `get Faloodeh`_ immediately.

Changes to GroupServer
======================

The changes in Faloodeh are mostly `group improvements`_, `profile 
improvements`_ and a new `site homepage`_. In addition we have made 
steps towards `easier installation`_, and there have been some `minor 
changes`_.

.. index:: Group

Group improvements
------------------

The most visible change to groups in this release of GroupServer is to 
the `notifications`_. However, the primary improvement is new code to 
determine if someone `can post`_ to a group. Underlying this is a system
for `more extensible groups`_.

Minor changes to groups include the following.

Better Links in Posts:
  Now ``http://youtu.be`` links are turned into embedded YouTube videos,
  and ``www.`` "links" are turned into hypertext links. Thanks to 
  `Steven Clift`_ at E-Democracy.Org for sponsoring this improvement.

Rest of Post Button:
  The button to show the *remainder* of a post (normally just 
  bottom-quoted text) is now labelled "Rest of post".

Public Access Period:
  The default public access period for files is now set to 72 hours.
  This is the period that no password is required to access a file, 
  making it easier for group members who follow conversations using
  email to access the files that are posted to the group.

.. index:: Notification

Notifications
~~~~~~~~~~~~~

Four notifications have been rewritten. There are HTML versions of both  

* The *Welcome* message [#Welcome]_, which is sent to new group members, 
  and 
* The *New Member* notification, which is sent to the administrator when
  someone joins a group [#NewMember]_.

The *Invitation* to join a group has undergone a rewrite too, along with
a new default invitation-message from the group-administrator.

Finally, the *Cannot Post* notification has undergone an extensive 
change, along with the rest of the `can post`_ system [#CannotPost]_. It
now has a HTML variant, as well as a wording change to (hopefully) make 
it easer to understand.

Can post
~~~~~~~~

The biggest change to groups was a complete rewrite of the system that
determines if a user can post. This system is used to 

* Send an email to someone who tries to post but is disallowed, and
* To tell someone using the web why he or she cannot post *before* they
  try to post.

The Can Post system is now self-documenting [#RulesList]_, and it allows
for `more extensible groups`_.

.. index::
   triple: Group; Type; Discussion
   triple: Group; Type; Announcement
   triple: Group; Type; Support

More extensible groups
~~~~~~~~~~~~~~~~~~~~~~

Along with the new `can post`_ code, the definition of what 
*constitutes* a group has been redefined. GroupServer has always 
supported three different types of group: 

Discussion Group:
  A group where only group members can post.
  
Announcement Group:
  A group where only certain group-members can post.

Support Group:
  A group where anyone can post, but only group-members can view the
  posts.

These group-types previously existed as a set of configuration options.
Now there are specific marker-interfaces for each of these group-types.
Currently only the `can post`_ system uses them extensively, but other
systems will follow in the future.

.. index:: Profile

Profile improvements
--------------------

The primary improvements to profiles is a new *Verify Email Address*
notification. Like the new `notifications`_ in the group, the new
Verify email message has a HTML version, which is shown by default by
most email clients. The wording of the Verify email has also been 
changed, so it is hopefully easier to understand.

All the notifications with an HTML component are possible because of a 
new system for sending notifications. This system is documented as part
of the ``gs.profile.notify`` component [#Notify]_.

Site homepage
-------------

The site homepage has been completely rewritten, but it looks largely
unchanged. Now the page — provided  by the new ``gs.site.home`` product
[#SiteHome]_ — can be skinned easily. Extra components can be easily 
added to it in the future.

.. index:: Installation

Easier installation
-------------------

Installation should be more reliable for three reasons. The first is a
change of dependencies. The second reason is a more tightly constrained 
set of software-sources. Finally, there is a new installation script.

Three dependencies have changed. 

#.  The least dramatic is to use `Pillow`_ rather than `PIL`_.  The
    former is a *friendly fork* of the latter, which works with the 
    ``easy_install`` system that GroupServer uses. This change removes
    the requirement to download and install both ``zlib`` and
    ``libjpeg``. The ``zlib`` dependency in particular was a problem
    with its frequent  changes. 

#.  The *eGenex mx Extension Series* is now available as an egg, which 
    we now use.

#.  Finally, the ``PyXML`` library is also provided by an egg [#xml]_.

By default the eggs used by the GroupServer installation process now 
come from only two sources. The eggs that make up GroupServer itself
come from <http://eggs.iopen.net/groupserver/base/>. The third-party
eggs come from <http://eggs.iopen.net/groupserver/cache/>. This should
prove to be more reliable than using the canonical *upstream* servers.

Finally, there is a new installer, the ``gs_install_ubuntu.sh`` script.
For an `Ubuntu`_ system, the new script installs the dependencies,
creates the databases in a secure maner, sets up a Python environment,
and installs all the GroupServer components.

Minor changes
-------------

There have been three sets of minor changes to GroupServer in the
Faloodeh release: Zope events are better supported, ``wsgi`` is
supported, and there have been numerous coding improvements.

An **event** in Zope is a signal that is raised when an action is 
carried out [#ZopeEvents]_. You can write code that subscribes to these 
events, and takes additional action. (This extra code does not need to 
alter the original code in any way.) Events are now raised when someone 
joins a group, joins a site, leaves a group, and leaves a site. This 
should make these actions more extensible, and allow others to add extra 
functionality to GroupServer [#SiteMember]_.

**WSGI** is the method that most Python-based web applications use to 
communicate to servers. GroupServer can now be served using WSGI, as
the last problems with WSGI compatibility have been resolved.

Finally, There have been numerous **coding improvements.** Most have 
centred around the use of `caching`_. In addition there are new base 
classes for pages and `viewlets`_ with GroupServer sites, profiles, and
groups.

Get Faloodeh
============

To get Faloodeh go to `the Downloads page for GroupServer`_ and
follow `the GroupServer Installation documentation`_. Those who already
have a functioning installation can `update an existing GroupServer
system`_.


Update an Existing GroupServer System
-------------------------------------

The update an existing GroupServer system to Faloodeh requires you to
first `update the packages`_. Then there are two tasks to be carried out
in the ZMI: first `update the site marker-interface`_, and then the 
complex task to `update the group marker-interface`_

Update the Packages
~~~~~~~~~~~~~~~~~~~

To update the packages carry out the following steps.

#.  Download the Faloodeh tar-ball from `the GroupServer download page
    <http://groupserver.org/downloads>`_.

#.  Uncompress the tar-ball.
   
#.  Copy the file ``groupserver-12.05/update-versions.cfg`` to your 
    existing GroupServer installation, under the name ``versions.cfg``.
   
#.  Copy the file ``groupserver-12.05/update-buildout.cfg`` to your 
    existing GroupServer installation, under the name ``buildout.cfg``.

#.  Copy the file ``groupserver-12.05/zope2-2.13.13.cfg`` to your 
    existing GroupServer installation.

#.  Copy the file ``groupserver-12.05/ztk-versions-1.0.6.cfg`` to your 
    existing GroupServer installation.

#.  In your existing GroupServer installation run::

      $ ./bin/buildout

#.  Restart your GroupServer instance.

Update the Site Marker-Interface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The `site homepage`_ improvements require a modification to the sites in
the ZMI before they can be seen. To update the sites, carry out the 
following steps.

#.  Log into the ZMI for your GroupServer Installation

#.  Navigate to your GroupServer instance in the ZMI (called 
    ``groupserver`` by default).

#.  Add a script by selecting ``Script (Python)`` from the *Add* menu
    near the top-right of the ZMI page.

    * Give the new script the Id ``add_new_site_homepage``
    * Click the *Add and edit* button.

#.  Change the contents of the script to the following::

      # --=mpj17=-- The new site home page in gs.site.home works of the single
      # IGSSiteFolder marker. As such the old IGSFullPageContentFolder marker
      # from the "paragmatic tempalates" code is not needed. Indeed, it gets
      # in the way. This code removes the IGSFullPageContentFolder marker
      # interface.
      from Products.XWFCore.XWFUtils import remove_marker_interfaces

      site_root = context.site_root()
      folders = ['Folder', 'Folder (Ordered)']
      isSite = lambda d: d.getProperty('is_division', False) and hasattr(d, 'groups')
      interfaces = ('Products.GSContent.interfaces.IGSFullPageContentFolder',)
      ignore = []

      contentFolders = site_root.Content.objectValues(folders)
      sites = [ s for s in contentFolders
                if ((s.getId() not in ignore) and 
                    (s.getProperty('is_division', False)) and 
                    (hasattr(s, 'groups'))) ]

      print '<html><head><title>Site update</title></head><body>'
      for site in sites:
          print '<hr/>'
          print '<p>%s (<code>%s</code>)</p>' % (site.title_or_id(), site.getId())
          remove_marker_interfaces(site, interfaces)
          print '<p>Removed the content marker</p>'
      print '</body></html>'
      return printed

#.  Click the *Save Changes* button.

#.  Click the *Test* tab. The marker interfaces for all the sites
    should be updated.

Update the Group Marker-Interface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Updating the marker-interfaces in a group is similar to how you 
`update the site marker-interface`_.

#.  Log into the ZMI for your GroupServer Installation

#.  Navigate to your GroupServer instance in the ZMI (called 
    ``groupserver`` by default).

#.  Add a script by selecting ``Script (Python)`` from the *Add* menu
    near the top-right of the ZMI page.

    * Give the new script the Id ``remove_xwf_chat_group_marker``
    * Click the *Add and edit* button.

#.  Change the contents of the script to the following::

      from Products.XWFCore.XWFUtils import remove_marker_interfaces, add_marker_interfaces,

      site_root = context.site_root()
      folders = ['Folder', 'Folder (Ordered)']
      ignore = []

      isSite = lambda d: d.getProperty('is_division', False) and hasattr(d, 'groups')

      contentFolders = site_root.Content.objectValues(folders)
      sites = [ s for s in contentFolders 
                if ((s.getId() not in ignore) and  isSite(s)) ]

      groups = []
      isGroup = lambda g: g.getProperty('is_group', False)
      for site in sites:
          groupsFolder = getattr(site, 'groups')
          groups += filter(isGroup, groupsFolder.objectValues(folders))
          
      oldInterfaces = ['Products.XWFChat.interfaces.IGSGroupFolder']
      newInterfaces = ['gs.group.type.discussion.interfaces.IGSDiscussionGroup']
      for group in groups:
        print 'Remove the XWFChat marker from %s (%s)' % (group.title_or_id(), group.getId())
        remove_marker_interfaces(group, oldInterfaces)
        add_marker_interfaces(group, newInterfaces)
      return printed

#.  Click the *Save Changes* button.

#.  Click the *Test* tab. The marker interfaces for all the groups
    should be updated to *discussion* groups.

#.  Change the *support* groups to the correct marker-interface by
    carrying out the following for each group.
    
    #.  Navigate to the group.

    #.  Click on the *Interfaces* tab.
    
    #.  Select ``gs.group.type.discussion.interfaces.IGSDiscussionGroup`` 
        in the *Provided Interfaces* list.
        
    #.  Click the *Remove* button. The discussion-group marker interface
        will be removed.
    
    #.  Select ``gs.group.type.support.interfaces.IGSSupportGroup``
        in the *Available Marker Interfaces* list.
    
    #.  Click the *Add* button. The support-group marker interface
        will be added.
        
#.  Change the *announcement* groups to the correct marker-interface by
    carrying out the following for each group.
    
    #.  Navigate to the group.

    #.  Click on the *Interfaces* tab.
    
    #.  Select ``gs.group.type.discussion.interfaces.IGSDiscussionGroup`` 
        in the *Provided Interfaces* list.
        
    #.  Click the *Remove* button. The discussion-group marker interface
        will be removed.
    
    #.  Select 
        ``gs.group.type.announcement.interfaces.IGSAnnouncementGroup``
        in the *Available Marker Interfaces* list.
    
    #.  Click the *Add* button. The announcement-group marker interface
        will be added.

#.  Finally, remove the legacy group-support from your site:

    #.  Copy the file ``groupserver-12.05/versions.cfg`` to your 
        existing GroupServer installation, under the name 
        ``versions.cfg``.
       
    #.  Copy the file ``groupserver-12.05/buildout.cfg`` to your 
        existing GroupServer installation, under the name 
        ``buildout.cfg``.

    #.  In your existing GroupServer installation run::

          $ ./bin/buildout -N
    
    #.  Restart your GroupServer instance.    
    
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
    http://creativecommons.org/licenses/by-sa/3.0/nz/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Richard Waid: http://groupserver.org/p/richard
..  _Dan Randow: http://groupserver.org/p/danr
..  _Steven Clift: http://groupserver.org/p/stevenc
..  _Facebook: https://facebook.com/
..  _The Downloads page for GroupServer: http://groupserver.org/downloads
..  _The GroupServer Installation documentation: 
    http://groupserver.org/downloads/install
..  _caching: http://docs.zope.org/zope.cachedescriptors
..  _Viewlets: https://pypi.python.org/pypi/zope.viewlet
..  _Pillow: https://pypi.python.org/pypi/Pillow/
..  _PIL: http://www.pythonware.com/library/
..  _Ubuntu: http://www.ubuntu.com/
..  _contact us: http://groupserver.org/groups/development/
..  [#Welcome] A sample *Welcome* message can be viewed at
    <http://groupserver.org/groups/development/new-member-msg.html>
..  [#NewMember] A sample *New Member* message can be viewed at
    <http://groupserver.org/groups/development/new-member-admin-msg.html>
..  [#CannotPost] A sample *Cannot Post* message can be viewed at
    <http://groupserver.org/groups/development/cannot-post.html>
..  [#RulesList] The Can Post system now produces a *Rules List* that
    shows the rules that are checked whenever someone posts to the 
    group. Example lists can be seen for `the GroupSever Development
    group <http://groupserver.org/groups/development/rules-list.html>`_
    and `the GroupServer Announcement Group
    <http://groupserver.org/groups/groupserver_announcements/rules-list.html>`_
..  [#Notify] The documentation for how to write a notification is 
    in `the product.
    <https://source.iopen.net/groupserver/gs.profile.notify/summary>`_
..  [#SiteHome] The documentation for how to add components to the new
    site homepage is in `the site-homepage product.
    <https://source.iopen.net/groupserver/gs.site.home/summary>`_
..  [#xml] Two other libraries, ``libxml2`` and ``libxslt``, are brought 
    into the system  by a small script, which is part of the buildout
    process. The global libraries *are* used, but they must be 
    symbolically-linked (*symlinked*) because the ``virtualenv`` system
    does not link to them.
..  [#ZopeEvents] The Zope events are provided by `the ZTK 
    documentation. <http://docs.zope.org/zope.event/>`_
..  [#SiteMember] `The site-member product 
    <https://source.iopen.net/groupserver/gs.site.member/summary>`_
    provides an example of code that both *subscribes* to an event and
    *raises* an event.

