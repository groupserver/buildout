.. _faq:

Frequently asked questions
==========================

.. Markup cribbed off the Sphinx FAQ
.. <http://www.sphinx-doc.org/en/stable/_sources/faq.txt>

If you have a question that is missing from the list below feel
free to ask in the `GroupServer Development`_ group.

.. _GroupServer Development: http://groupserver.org/groups/development

How do I...
-----------

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
  #. Visit the :file:`/groupserver/ListManager`  folder.
  #. For every group in the folder

     #. Open the group object.
     #. Edit the ``mailto`` property to the new valie.
     #. Click the *Save changes* button.

  <http://groupserver.org/r/post/78hOqzXeQ0IOO9UYGxIsKZ>

.. index:: Support!
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

.. index:: Editable page!

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
   pair: Group; Support

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

.. index:: root!

.. _rootInstall:

... so many errors when installing?
  GroupServer can only run as a normal user, never as the
  ``root`` superuser. Change the ownership of the GroupServer
  directory and all of its contents to a normal user.

  <http://groupserver.org/r/post/5pZmyC9GUCCxmRlZzOfj7R>
