=================
Translation guide
=================

:Authors: `Alice Rose`_; `Michael JasonSmith`_; 
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
through how to `translate GroupServer`_, how to `add
internationalisation (i18n)`_, and finally we discuss how to
`update the products`_.

Change the language
-------------------

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
(probably either `Michael JasonSmith`_ or `Alice Rose`_) will
then carry out the following tasks.

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

                @form.action(name="change", label=_('change-action', 'Change'),
                             failure='handle_change_action_failure')
                def handle_invite(self, action, data):

          When actually adding i18n to a command button in a
          ``zope.formlib`` form remember to **set a name,** that
          way the element-identifier will be the same no matter
          the language.

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

    #. Add ``i18n:name`` attributes to dynamic content.

        .. code-block:: xml

           <span class="group" i18n:name="groupName"
                 tal:content="view/groupInfo/name">this group</span>

    #. Add ``i18n:attributes`` attributes to dynamic attributes.

        .. code-block:: xml

           <a title="Change this About box"
              i18n:attributes="title admin-change-button-title">Change</a>

#.  Add i18n to the Zope Configuration file.


    #.  Add the ``i18n`` namespace

        .. code-block:: xml

           <configure xmlns="http://namespaces.zope.org/zope"
                      xmlns:browser="http://namespaces.zope.org/browser"
                      xmlns:i18n="http://namespaces.zope.org/i18n">

    #.  Add the ``reigsterTranslations`` element

        .. code-block:: xml

           <i18n:registerTranslations directory="locales" />

#.  Run the latest version of ``i18n.sh`` [#i18n]_ in the base
    directory of the product to create and update the
    translation.

#.  Fill out the *English* translation, which is used as the
    source translation for Transifex.

#.  Commit the changes.

#.  Add the product to Transifex [#client]_.

    #.  In `the GroupServer organisation on Transifex`_, click on
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

    #.  Run ``tx-set.sh`` [#tx-set]_ in the base directory of the
        product.

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

Update the products
===================

Transifex and the product need to be kept in sync with each
other. When the product changes it is necessary to `update
Transifex with the new strings`_. Likewise, when some
translations have been completed it is necessary to `update the
product with the new translations`_.

Update Transifex with the new strings
-------------------------------------

To update a Transifex project with the new strings in a product
carry out the following tasks.

#.  Update the ``pot`` file and the ``po`` files by running the
    ``i18n.sh`` script in the root of the product [#i18n]_.

#.  Update the *English* ``po`` file, copying the default text
    into the ``msgstr``. This is the *source* language that
    supplies the example text in Transifex. (Without this step
    the translations can still take place, but the translators
    see the message identifiers, rather than the default text.)

#.  Push the changes in the source file to Transifex, using the
    Transifex client (``tx``):

    .. code-block:: console

       $ tx push -s

#.  Commit and push the changes to the source-code repositories.

Update the product with the new translations
--------------------------------------------

To update a product with the new translations in a Transifex
project carry out the following tasks.

#.  Pull the updated translations (in ``po`` files) from the
    Transifex project using the Transifex client (``tx``):

    .. code-block:: console

       $ tx pull -a

#.  Ensure that Zope is set up to automatically compile the
    ``po`` files to ``mo`` files:

    .. code-block:: console

       $ export zope_i18n_compile_mo_files=true

#.  Start your development system. `Change the language`_ in your
    browser to test the different translations.

    :Note: Browsing the Web with a changed language will result
           in Goggle, Microsoft, the NSA, and Yahoo! getting some
           funny ideas about that languages you can comprehend.

#.  Commit and push the changes to the source-code repositories.

..  _GroupServer: http://groupserver.org/
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Creative Commons Attribution-Share Alike 4.0 International License:
    http://creativecommons.org/licenses/by-sa/4.0/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Alice Rose: https://twitter.com/heldinz
.. _the GroupServer development group:
   http://groupserver.org/groups/development
.. _the GroupServer organisation on Transifex:
   https://www.transifex.com/organization/groupserver/dashboard

.. [#i18n] Download ``i18n.sh`` from
           <http://groupserver.org/downloads/i18n.sh>. It wraps
           the marvellous i18ndude_: ``$ pip install i18ndude``

.. _i18ndude: https://pypi.python.org/pypi/i18ndude/

.. [#client] Ensure you have ``transifex-client`` 0.11.1 beta or
             later installed: 
             ``$ pip install transifex-client==0.11.1.beta``

.. [#tx-set] Download ``tx-set.sh`` from 
             <http://groupserver.org/downloads/tx-set.sh>

..  LocalWords:  Transifex
