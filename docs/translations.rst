=================
Translation guide
=================

:Authors: `Michael JasonSmith`_;
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2015-02-18
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International
  License`_ by `OnlineGroups.net`_.

Introduction
============

GroupServer_ is written in English, and the interface has been
partly translated into French and German. In this guide we work
through how to `Translate GroupServer`_ and how to `Add
internationalisation (i18n)`_.

Changing the language
---------------------

Your browser determines the language that is chosen when
GroupServer displays a page. To change what language is chosen
alter the *Preferred languages*, or *Language and input* setting
in your browser preferences (options).

Translate GroupServer
=====================

Anyone can help improving the translations of GroupServer! We use
`the Transifex system`_ to help make the translations: it is a
web-based system that allows you to translate GroupServer bit by
bit. **All you need is a browser.** If you have any questions
please feel free to ask away in `the GroupServer development
group`_.

.. _the Transifex system:
   https://www.transifex.com/organization/groupserver/dashboard

Add internationalisation (i18n)
===============================

Adding internationalisation support to a product that lacks it is
a development task. If you come across a component of GroupServer
that lacks a translation please **ask for i18n to be added** in
`the GroupServer development group`_. The person who responds
(either `Michael JasonSmith`_ or `Alice Murphy`_) will then carry
out the following tasks.

#.  Identify the product. (The element identifiers in the HTML
    often point to the product that needs to be changed.)
#.  Add a ``locales`` directory to the product, in the same
    directory that has the ``configure.zcml`` file.

#.  Add i18n to the Python code.

    #.  To the ``__init__.py`` for the product instantiate a
        message factory, passing the name of the product as an
        argument:

        .. code-block:: py

           from zope.i18nmessageid import MessageFactory
           GSMessageFactory = MessageFactory('gs.groups')

    #.  Identify the Python products that contain strings that
        need translating. To each add the following ``import``:

        .. code-block:: py

           from . import GSMessageFactory as _

    #.  Add i18n to all the strings:

        * All strings, including the simple ones, get a label
          with the default (English) text following. The label
          make Transifex much easier to deal with.

          .. code-block:: py

             _('start-button', 'Start')

        * Complex strings have a ``mapping`` keyword argument,
          and a ``${}`` template syntax (rather than ``{}`` for
          Python format-strings).

          .. code-block:: py

             _('start-status',
               'The group ${groupName} has been started.',
               mapping={'groupName': r})

#.  Add i18n to the page templates.

    #.  Add the ``i18n`` namespace to the page template, using
        the product name as the domain.

        .. code-block:: xml

           <html xmlns:i18n="http://xml.zope.org/namespaces/i18n"
                 i18n:domain="gs.group.start">

    #. Add ``i18n:translate`` attributes to all elements that
       require translation. Always set the translation ID.

        .. code-block:: xml

           <p id="group-id-error" style="display:none;" class="alert"
              i18n:translate="group-id-used">
              <strong class="label alert-label">Group ID In Use:</strong>
              The Group ID <code>above</code> is already being used.
              Please pick another group ID.
           </p><!--group-id-error-->

    #. Add ``i18n:name`` attributes to dynamic content

        .. code-block:: xml

           <span class="group" i18n:name="groupName"
                 tal:content="view/groupInfo/name">this group</span>

#.  Add i18n to the Zope Configuration file.


    #.  Add the ``i18n`` namespace

        .. code-block:: xml

           <configure xmlns="http://namespaces.zope.org/zope"
                      xmlns:browser="http://namespaces.zope.org/browser"
                      xmlns:i18n="http://namespaces.zope.org/i18n">

    #.  Add the ``reigsterTranslations`` element

        .. code-block:: xml

           <i18n:registerTranslations directory="locales" />

#.  Run the latest version of ``i18n.sh`` [#i18n]_ to create and
    update the translation.

#.  Commit the changes.

#.  Add the product to Transifex [#client]_.

    #.  In `the GroupServer organisation on Tranifex`_, click on
        *New project*.

    #.  Fill in the Project Details form:

        * Use the GroupServer product identifier as the name
          (e.g. ``gs.site.about``).
        * Source language is always English.
        * The License is always "Permissive open-source".
        * Source Code URL is the GitHub URL.

    #.  Assign to the project to the GroupServer Team.

    #.  Skip "Add content".

    #.  Create the project.

    #.  View the new project.

    #. Choose the *Manage* link.

    #. Under *Project URL*, add hyphens where Transifex has
       removed dots from the project name (e.g. ``gssiteabout`` →
       ``gs-site-about``).

    #. Optionally add a *Long Description* from the
       *Introduction* section of the product ``README.rst``.

    #.  *Save*.

    #.  Update the ``README.rst`` to include a Transifex link in
        the *Resources* section.

        .. code-block:: rst

           - Translations: https://www.transifex.com/projects/p/gs-group-encouragement/

    #.  Initialise the product, accepting the defaults:

        .. code-block:: console

           $ tx init

    #.  Run ``tx-set.sh`` [#tx-set]_.

    #.  Sync local source and translations to remote:

        .. code-block:: console

           $ tx push -s -t

    #.  Pull the translations, now modified by Transifex from
        remote to local:

        .. code-block:: console

           $ tx pull -a

    #. Commit the Transifex configuration (``.tx/``) and the
       modified translations to version control.

#. Push all the changes to the repositories.

..  _GroupServer: http://groupserver.org/
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Creative Commons Attribution-Share Alike 4.0 International License:
    http://creativecommons.org/licenses/by-sa/4.0/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Alice Murphy: http://groupserver.org/p/alice
.. _the GroupServer development group:
   http://groupserver.org/groups/development
.. _the GroupServer organisation on Tranifex:
   https://www.transifex.com/organization/groupserver/dashboard

.. [#client] Ensure you have ``transifex-client`` 0.11.1 beta or
             later installed

             .. code-block:: console

                $ pip install transifex-client==0.11.1.beta

.. [#i18n] Download ``i18n.sh`` from
           <http://groupserver.org/downloads/i18n.sh>

.. [#tx-set] Download ``tx-set.sh`` from 
             <http://groupserver.org/downloads/tx-set.sh>

..  LocalWords:  Transifex
