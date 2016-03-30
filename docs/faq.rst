.. _faq:

Frequently asked questions
==========================

:Authors: `Michael JasonSmith`_;
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2016-03-30
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International
  License`_ by `OnlineGroups.net`_.

..  _Creative Commons Attribution-Share Alike 4.0 International License:
    https://creativecommons.org/licenses/by-sa/4.0/

.. Markup cribbed off the Sphinx FAQ
.. <http://www.sphinx-doc.org/en/stable/_sources/faq.txt>

If you have a question that is missing from the list below feel
free to ask in the `GroupServer Development`_ group.

.. _GroupServer Development: http://groupserver.org/groups/development

How do I...
-----------

.. index::
   triple: Group; Email address; Change

.. _changeEmail:

... change the email address for a group?
  The email address for a group is normally the group-identifier
  followed by the domain name for the site. However, it can be
  changed:

  #. Open the list object in the :file:`/groupserver/ListManager`
     folder.
  #. Edit the ``mailto`` property to the new value.
  #. Click the *Save changes* button.

  <http://groupserver.org/r/post/5mOm2zRgLhDxWFxreDP2EI>

.. index::
   pair: Configuration; Host name

.. _changeHostname:

... change the host name?
  The host-name is normally set during
  :doc:`installation. <groupserver-install>` However, it can be
  changed afterwards.

  #. Visit the :file:`/groupserver/` folder in the
     :ref:`ZMI <ZMI Login>`.
  #. Open the ``GlobalConfiguration`` object.
  #. Edit the ``canonicalHost`` property to the new value.
  #. Click the *Save changes* button.
  #. Visit the :file:`/groupserver/ListManager` folder.
  #. :ref:`Change the email address <changeEmail>` for every
     group in the folder

  <http://groupserver.org/r/post/78hOqzXeQ0IOO9UYGxIsKZ>

.. index:: !Support
   pair: Support; Email

.. _changeSupport:

... change the support email?
  The email address for support is first set during the
  :doc:`GroupServer installation. <groupserver-install>` To
  change it

  #. Visit the :file:`/groupserver/` folder in the
     :ref:`ZMI <ZMI Login>`,
  #. Open the ``GlobalConfiguration`` object, and
  #. Edit the ``supportEmail`` property.
  #. Click the *Save changes* button.

  <http://groupserver.org/r/post/2rO2bKiq6X4UjZ9MmYkZ8S>

.. index:: !Editable page

.. _createPage:

... create a page?
  Some pages in GroupServer (such as ``/about``) are editable.

  #. Visit the folder that should contain the page in the
     :ref:`ZMI <ZMI Login>`.
  #. Add a new folder.
  #. Visit the new folder.
  #. Select the *Interfaces* tab.
  #. Select
     ``Products.GSContentManager.interfaces.IGSContentManagerFolderMarker``
     in the *Available Marker Interfaces* list.
  #. Click the *Add* button.

  <http://groupserver.org/r/post/77U0Vt8tiiaSbxm05JXfay>

.. index::
   pair: Email; Delete

.. _deletePost:

... delete a post?
  Once a post has been made then the group members will receive
  an email message containing that post, and there is no way to
  recall the message. However, a post can be hidden in the
  archive: click the :guilabel:`Hide` button next to the
  post. The post will be replaced with a message saying why it
  was deleted.

  To actually delete a post:

  * Any associated files must be removed from the ``file`` table,
  * The ``first_post_id``, ``last_post_id`` and ``num_posts``
    must be updated in the ``topic`` table, and
  * The post itself must be removed from the ``post`` table.

  After deleting a post anyone following a link to the post on
  the archive (from the earlier message) will see a ``404 (Not
  found)`` error rather than the nicer ``410 (Gone)`` error.

  <http://groupserver.org/r/post/11BNEy4jQtmKL5UaE0ERvh>

.. index:: !DMARC
   pair: Email; DMARC

.. _dmarc:

... disable email address obfuscation?
   You cannot disable this feature. If a person posts from a
   domain controlled by DMARC (:rfc:`7489`) then GroupServer
   rewrites the :mailheader:`From` header so others will receive
   the message. (If this was skipped then the message will fail
   the DMARC check and the group members would never see the
   message.) This conforms to `the draft DMARC interoperability
   specification.`_

   .. _the draft DMARC interoperability specification.:
      https://tools.ietf.org/html/draft-ietf-dmarc-interoperability-13#section-4.1.1.1

   <http://groupserver.org/r/post/3aBYSugEuqZuTFnFMYakL1>

.. index::
   pair: Email; Import

.. _importPosts:

... import posts from another system?
   To import posts from another system first export the posts as
   an ``mbox`` file, then use the :command:`mbox2gs` script to
   import the posts into GroupServer
   `(documentation). <http://groupserver.readthedocs.org/projects/gsgroupmessagesaddmbox2gs/en/latest/>`_

   <http://groupserver.org/r/post/83qZzkEAFBN1tEeXv1Dkf>

.. index::
   triple: Group; Member; Moderate

.. _allModerated:

... make all the members of a group moderated?
  Ideally you would change the moderation of a group to *Moderate
  specified members, and all new members that join this group*
  before the new members are added. However, if this was skipped,
  and a large number of people has been added, then it is
  possible to set the list of moderated members.

  #. Visit the :file:`/groupserver/` folder in the
     :ref:`ZMI <ZMI Login>`.
  #. Open the ``acl_users`` object.
  #. Select the *User groups* tab.
  #. Open the user-group.
  #. Copy the list of user-identifiers from the *Users* list into
     a text editor.
  #. Remove the identifiers for each the administrator and
     moderator.
  #. Visit the :file:`/groupserver/ListManager` folder in the
     ZMI.
  #. Open the mailing list object for the group.
  #. Copy the list of members to be moderated from the text
     editor into the ``moderated_members`` list.
  #. Click the *Save changes* button.

  <http://groupserver.org/r/post/7r2kAxK3Y4zUPJgvl2A2rz>

.. index::
   pair: User; Delete
   pair: Profile; Delete

.. _removeUser:

... remove a user?
  When a person leaves their last group on a site they are no
  longer a site member, but they will still have a
  user-object. These objects can be deleted, but it is
  discouraged.

  #. Visit the :file:`/groupserver/` folder in the
     :ref:`ZMI <ZMI Login>`,
  #. Open the ``acl_users`` object,
  #. Select the user-object to delete, and
  #. Click the ``Delete`` button.

  <http://groupserver.org/r/post/tXN8SrD8dcrfyqKdD8QgZ>

.. index::
   pair: Email; Virus scan

.. _scanVirus:

... scan for viruses?
  Install `pyClamd. <http://xael.org/pages/pyclamd-en.html>`_

  <http://groupserver.org/r/post/36Os84MG4oZgi5GPtPhGvr>

.. index:: Support
   triple: Group; Type; Support

.. _multipleSupport:

... set multiple people to receive the support email?
  The easiest way for multiple people to receive messages to the
  Support email address is to create a new *Support group*.

  #. Start a *secret* group.
  #. Change the *group* *type* to *Support*.
  #. Add the people who need to receive the messages to support
     to the group.
  #. :ref:`Change the support email address <changeSupport>` to
     the email address of the new group.

  <http://groupserver.org/r/post/4Hr99NYlpzmoQqnFVH2ira>

.. index::
   pair: Email; Hide
   pair: Profile; Password

.. _hideFeature:

... turn off a feature?
  Normally the easiest way to turn off a feature is to hide it in
  the CSS.

  #. Get used to :ref:`changing the skin. <skin>`
  #. Make your own skin, based off the Blue or Green skin (see
     :doc:`development`).
  #. Hide the interface element in question by setting it to
     ``display: none``.

  * Hide post: <http://groupserver.org/r/post/3e6qousrx7qyvpsK0HsZUt>
  * Password toggle: <http://groupserver.org/r/post/7ezGHt8QtK9zdl82uSxrgo>

.. index:: Web page

Why do I see...
---------------

.. index::
   pair: Install; Distribute

.. _distribute:

... an error with distribute?
  Sometimes there is an issue with installing the ``distribute``
  package:

    | Error: There is a version conflict
    | We already have : distribute 0.6.24

  The solution is

  #. Go to your GroupServer folder,
  #. Get :command:`pip` to install the correct version of
     distribute:

     .. code-block:: console

       $ ./bin/pip install "distribute == 0.6.49"

  #. Carry on installing GroupServer:

     .. code-block:: console

       $ ./gs_install_ubuntu.sh

  <http://groupserver.org/r/post/64795Fwr7CrIF0CtywwrCf>

.. index:: !lxml
   pair: Install; Buildout

.. _lxml:

... "couldn't install: lxml"?
  To compile ``lxml`` the system needs at least 1024M of RAM.

  <http://groupserver.org/r/post/4tKMVOifDkPPKKcaiSUJvY>

.. index:: Skin
   pair: Email; Skin

.. _emailCSS:

... email messages with the wrong CSS?
  The web-hook that adds a message may use different URL to the
  one used for normal web traffic (see :ref:`skin`). If this is
  the case GroupServer may have to be explicitly told the skin to
  use.

  #. Visit the :file:`/groupserver/` folder in the
     :ref:`ZMI <ZMI Login>`,
  #. Open the ``GlobalConfiguration`` object,
  #. Set the ``emailSkin`` property to the same value that is
     used in the proxy configuration.

  <http://groupserver.org/r/post/47QGmyKwX9pkaLj6j8mzZe>

.. index::
   pair: Notification; Topic digest

.. _senddigest:

... "Error with the configuration file" when sending the digest?
  Specify the full path to the :file:`gsconfig.ini` on the
  command line to :command:`senddigest`. (See also
  :ref:`cronDigest`.)

  <http://groupserver.org/r/post/5s9tsZFDKPDHJS1JkunBun>

.. _noEmail:

... no email when I make a post?
  If you are testing, ensure that your group members are on
  :guilabel:`One email per post`.

  <http://groupserver.org/r/post/A0TVjgcUWJnFVbk82YsJh>

.. index:: Proxy, Web proxy, Postfix
   pair: Configuration; Proxy

.. _requestEntityTooLarge:

...  Request Entity Too Large?
  Email messages are added to GroupServer, by :doc:`postifx,
  <postfix-configure>` using a web-hook. Because of this the
  :doc:`proxy <proxy-configure>` can block a message if it is too
  large.  Adjust the ``client_max_body_size`` parameter in
  :program:`nginx` or similar variable in your proxy of choice.

  <http://groupserver.org/r/post/xXIumIpGyDIKgaifmxuRy>

.. index:: !root

.. _rootInstall:

... so many errors when installing?
  GroupServer can only run as a normal user, never as the
  ``root`` superuser. Change the ownership of the GroupServer
  directory and all of its contents to a normal user.

  <http://groupserver.org/r/post/5pZmyC9GUCCxmRlZzOfj7R>

..  _GroupServer: http://groupserver.org/
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
