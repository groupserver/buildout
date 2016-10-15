.. index:: !Development, source

=================
Development guide
=================

:Authors: `Michael JasonSmith`_;
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2016-10-13
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International
  License`_ by `OnlineGroups.net`_.

..  _Creative Commons Attribution-Share Alike 4.0 International License:
    https://creativecommons.org/licenses/by-sa/4.0/

.. highlight:: console

------------
Introduction
------------

In this guide I hope to introduce you to the tools used in the
`development process`_ for GroupServer_. I also hope to provide
an overview of the `system structure`_.

You can find out more about GroupServer development by reading
**the archive**, and asking questions, in the `GroupServer
development`_ group, joining `the #gsdevel channel`_ on
Freenode.net, or both.

.. _the #gsdevel channel: irc://irc.freenode.net/#gsdevel

-------------------
Development process
-------------------

The development process for GroupServer_ is straight forward, but
it may be different to what you are used to simply because of the
size and structure of the project. Here we cover using a `virtual
environment`_, before introducing you to the `version control
system`_ used for GroupServer.


Virtual environment
===================

The development for GroupServer takes place within the Python
*virtual environment* of a GroupServer installation (see
:doc:`groupserver-install`). When you start development you need
to **activate** the virtual environment:

.. code-block:: console

   $ . ./bin/activate

The command-prompt may change to indicate that you are now in a
virtual environment.

When you have done with development you can **deactivate** the
environment:

.. code-block:: console

   $ deactivate

.. index:: hg, git

Version control system
======================

Two version control systems are used to store the source-code for
GroupServer:

Git:
  GitHub_ hosts the canonical repository at
  <https://github.com/groupserver>

Mercurial:
  The Mercurial repository is hosted on a Redmine site that has a
  self-signed HTTPS certificate
  <https://source.iopen.net/groupserver>

You can use either system, but I recommend that people use GitHub
because they are more likely to have an account there. However,
you will almost certainly lack the permissions required to *push*
any changes. To ensure your changes are not lost you should `fork
a repo`_ and commit any changes you make there. Once you are done
you can make a `pull request`_.

.. _fork a repo: https://help.github.com/articles/fork-a-repo/
.. _pull request: https://help.github.com/articles/using-pull-requests/

.. index:: Mr.Developer
   pair: Install; development
   pair: Install; buildout

:mod:`mr.developer`
===================

I recommend that you use :mod:`mr.developer` (PyPI_) to integrate
your development with the buildout_ system that builds
GroupServer. In this section we will cover its installation_ with
:program:`buildout`, its usage_, and the `development
configuration file`_.

.. index:: i18n, i18ndude, transifex

Installation
------------

Enter your virtual environment using `activate` as above, then:

.. code-block:: console

  $ buildout -N -c develop.cfg

This builds your site (the same as a normal
:doc:`groupserver-install`) along with the :mod:`mr.developer`
script :program:`develop`. (Two scripts to help with
internationalisation, :program:`i18ndude` and :program:`tx` are
also installed; see the :doc:`translations` for more
information.)

Usage
-----

First you will need code to work on. Use :mod:`mr.developer` to
**checkout** the source-code from the repository:

.. code-block:: console

   $ develop checkout gs.group.home

This will checkout the :mod:`gs.group.home` *product* from `its
repository`_ into the :file:`src/gs.group.home` directory within
your GroupServer installation. (There is more on products_
below.)

.. _its repository: https://github.com/groupserver/gs.group.home

Next you will have to rebuild GroupServer to update all the
configuration to point to the new code:

.. code-block:: console

   $ buildout -N -c develop.cfg

Now any changes that you make to the code in
:file:`src/gs.group.home` will change your version of
GroupServer.

When you have finished making changes you want you should commit
them, and push your changes up to a repository. To resume using
the standard version of a product **deactivate** the source code
version of the product and rebuild GroupServer:

.. code-block:: console

    $ develop deactivate gs.group.home
    $ buildout -N -c develop.cfg

Development configuration file
------------------------------

The configuration for :mod:`mr.developer` is in the
:file:`develop.cfg` file, which is very similar to the
configuration files that control the rest of the build.

The main configuration is in the ``[sources]`` section. This maps
each product that makes up GroupServer to the repository
location. Each line is of the form

.. code-block:: cfg

  name = kind url

``name``:
  The name of the product.

``kind``:
  The kind of version control system to use. For GroupServer
  development this will be either ``hg`` or ``git``. For your own
  development you may want to live dangerously and use ``fs`` for
  a product that lacks version control [#novcs]_.

``url``:
  The location of the repository. This is specific to the version
  control system.

When you make **your own changes** you will need to change the
URL to point to the repository provided by the `version control
system`_ that you use. The `default configuration`_ that ships
with GroupServer points to the canonical Git repositories for all
products.

.. index:: awk

Default configuration
~~~~~~~~~~~~~~~~~~~~~

The default configuration for :mod:`mr.developer` is generated
from the :file:`versions.cfg` file using the following
:command:`awk` script. It specifies that :command:`git` should be
used with all the products.

.. code-block:: awk

  BEGIN {
    FS=" = "
    vcs="git"
    dest="ssh://git@github.com:/groupserver/"
    print "[buildout]"
    print "extensions = mr.developer"
    print "sources = sources"
    print "auto-checkout = "
    print "\n[sources]"
  }
  $1 ~ /^((gs)|(Products.G)|(Products.XWF)).*/ {
    printf "%s = %s %s%s\n", $1, vcs, dest, $1
  }

To change Mr Developer to use :program:`Mercurial` as the default
version-control system, but use :program:`GitHub` as the primary
repository, carry out the following tasks.

#. Install `the Hg-Git plugin`_ for Mercurial.

#. Copy the above :command:`awk` script to the file
   :file:`emit-devel.awk`.

#. Change the ``vcs`` variable to ``hg``.

#. Add ``git+`` to the start of the value for the ``dest``
   variable.

#. Run the command:

     .. code-block:: console

       $ awk -f emit-devel.awk < versions.cfg > new-develop.cfg

#. Check that the new configuration is to your liking and move
   the new configuration into place:

     .. code-block:: console

        $ mv new-develop.cfg develop.cfg

.. _the Hg-Git plugin: http://hg-git.github.io/

.. index:: customisation

Adding a new product
====================

GroupServer is split into multiple *products*, each controlling
one aspect of the system. (There is more on products_ below.) To
add your own functionality, or override existing functionality,
you will need to add your own product.

To add your own new product to GroupServer carry out the
following tasks.

#. Create the product in the ``src`` directory. Normally I copy
   an existing product:

   + Rename the product, the directories in the product
     namespace, and the configuration in the ``setup.py``.

   + Delete the old code — keeping a blank ``__init__.py`` at the
     top, and the ``__init__.py`` files needed for the
     namespace_.

   + Delete the contents of the ``<configure>`` element of the
     ``configure.zcml`` file, keeping the element itself.

#. Add the name of your product to the ``custom-zope-eggs``
   section of the ``custom.cfg`` file.

#. Add the version-control information for the product to the
   `development configuration file`_.

#. Activate the product:

     .. code-block:: console

        $ develop activate your.product.name

#. Rebuild GroupServer:

     .. code-block:: console

        $ buildout -N -c develop.cfg

.. index:: Pyramid, Zope component architecture, ZCA

----------------
System structure
----------------

GroupServer_ belongs to a family of systems that share underlying
technology:

* `Zope component architecture`_
* Plone_
* Pyramid_
* Chameleon_
* Python_

.. _Zope component architecture: http://docs.zope.org/zope.component/
.. _Python: https://www.python.org/
.. _Pyramid: http://www.pylonsproject.org/
.. _Plone: https://plone.org/
.. _Chameleon: http://chameleon.readthedocs.io/

The source-code for GroupServer is split into many products_,
with the documentation_ provided by reStructuredText_. It is all
coordinated by buildout_.

.. index:: !Buildout, !eggs

Buildout
========

Buildout assembles and deploys the different parts that make up
GroupServer. The basic idea is that the high-level *components*
are specified by buildout. For GroupServer all the components are
Python products_, which are installed as **eggs**. Each Python
product specifies its dependencies in the
:file:`setup.py`. However, buildout restricts the *versions* that
are installed, ensuring that a *known good set* of products is
installed.

Buildout is controlled by the ``*.cfg`` files at the top of your
GroupServer installation directory. There are three `main
files`_, and seven `supplementary files`_, all of which are in
``INI`` format.

.. _main files:

Main configuration files
------------------------

The three main files specify the ways the products can be
deployed.

:file:`buildout.cfg`:
  Controls the installation of all the components that make up
  GroupServer, up to the point that the unit tests can be run,
  but it stops short of creating the site::

       $ buildout
       $ testrunner -k --auto-color --udiff -m gs\\..*

:file:`site.cfg`:
  Extends :file:`buildout.cfg` by adding the *recipes* (buildout
  scripts) that actually initialise the database and create the
  GroupServer site (if necessary). This is the normal way to
  build GroupServer::

       $ buildout -c site.cfg

:file:`develop.cfg`:
   Extends :file:`site.cfg` by adding the components that allow
   for development: :mod:`mr.developer`, :mod:`i18ndude`, and
   :mod:`transifex-client`::

       $ buildout -c develop.cfg

.. index:: ztk, zope tool kit

.. _supplementary files:

Supplementary configuration files
---------------------------------

The seven supplementary configuration files are used by the three
`main files`_ in a similar way to *modules*.

:file:`config.cfg`:
  The main site configuration that is written during
  :doc:`groupserver-install`. Used by :file:`site.cfg`.

:file:`custom.cfg`:
  The products that customise the install go in this
  configuration file. Initially it is mostly blank. Used by
  :file:`buildout.cfg`.

:file:`dependencies.cfg`:
  The *parts* that control the *recipes* that set up the base
  install. Used by :file:`buildout.cfg`.

:file:`instance.cfg`:
   The *parts* that control the *recipes* that install the
   initial GroupServer site (the *instance*). Used by
   :file:`site.cfg`.

:file:`versions.cfg`:
   The list of what specific versions should be installed. Used
   by :file:`buildout.cfg`.

:file:`zope2-2.13.24-versions-gs.cfg`:
   The configuration for the Zope2 web-application server that
   GroupServer is based on. Used by :file:`buildout.cfg`.

:file:`ztk-versions.cfg`:
   The configuration for the Zope Toolkit. Used by
   :file:`buildout.cfg`.

.. index::
   pair: Development; Python products

Products
========

GroupServer is split into many (currently 146) *products*: small
Python packages that deal with one aspect of the system. The
general rule is that **one product for each user interface**
(usually a form). While this may seem limiting, each product
usually contains

* The `page templates`_ that makes up the interface,
* The JavaScript that is specific to the page,
* The Python code that defines the behaviour of the interface,
* The Python code that handles storing the data and retrieving
  the data (using SQLAlchemy_),
* The SQL code that defines any product-specific tables,
* The user-help, and
* The code documentation.

This tends to be more than enough for each product.

If more than one product relies on the same code then that code
is normally refactored into a **base product** — which is
normally given a name ending in ``.base``, such as
``gs.group.list.base``.

Development is carried out on one, or a few, products at a
time. If you are unsure what products provide aspect of
GroupServer it would be best to **ask** in `GroupServer
development`_ or in ``#gsdevel`` on IRC. However, there are some
clues: normally name of the product will make up the part of the
identifier or class-name of an element in the HTML source of a
page. For example, the link to the ATOM feed of posts on the
*Group* page has the identifier ``gs-group-messages-posts-link``
— which indicates that it is provided by `the
gs.group.messages.posts product`_.

.. code-block:: xml

  <link id="gs-group-messages-posts-link" rel="alternate"
      type="application/atom+xml"
      title="Posts in GroupServer development"
      href="/s/search.atom?g=development&amp;t=0&amp;p=1" />

.. _the gs.group.messages.posts product: https://github.com/groupserver/gs.group.messages.posts

Each product makes use of namespaces_, and ZCML_. Each product
usually contains some `static resources`_, `page templates`_, and
some documentation_

.. _namespace:

Namespaces
----------

The products use *namespace packages* (:pep:`420`).

* Each part of the namespace is separated by dots. For example,
  the code that produces for `the plain-text version of an email
  message`_ is ``gs.group.list.email.text``.

* Each GroupServer product belongs beneath the ``gs``
  namespace. Beneath that there are many others. The three large
  ones are for the three main agents in GroupServer:

  ``gs.group``:
    Groups, including mailing list functionality (``gs.group.list``).

  ``gs.profile``:
    People, as represented by their profiles.

  ``gs.site``:
    The code relating specifically to a site.

  The other major namespace is ``gs.content``, which provides the
  **client side** code.

* The **root** of each product contains the packaging information
  for that product.

  + The configuration for setuptools_, particularly in the files
    :file:`setup.py`, :file:`setup.cfg`, and :file:`MANIFEST.in`.
    The first is the one with most of the information, in
    particular the dependencies for the package.

  + The :file:`README.rst`, which appears on GitHub.

  + The :file:`COPYRIGHT.txt`, and :file:`LICENSE.txt`.

* The documentation_ will be in the :file:`docs/` directory.

* **The Python code** is within nested sub-directories beneath
  the product directory, such as
  :file:`gs/group/list/email/text`. All but the last directory
  will have :file:`__init__.py` files that set the directory up
  as a *namespace directory*. The last directory (``text`` in
  this example) will have an :file:`__init__.py`. It is necessary
  to turn the directory into a Python module.

.. _the plain-text version of an email message:
    https://github.com/groupserver/gs.group.list.email.text

.. _setuptools: https://pypi.python.org/pypi/setuptools

The Python code is made up of an ``__init__.py`` that is often
blank, with each class in its own file. (This is my habit, you do
not have to follow it.) To determine the relationship between the
files, and the rest of GroupServer, it is necessary to look at
the ZCML_ file.

.. index:: ZCML, Zope Configuration Markup Language

ZCML
----

The Zope Configuration Markup Language (ZCML) defines the `static
resources`_, the `page templates`_, the relationship that the
Python files have to each other, and to other products. The
configuration for each product is always called
:file:`configure.zcml`, and it is always in the same directory as
all the Python files.

To begin with the three most important directives are as follows.

``<browser:resource />``:
  A `static resource`_.

``<browser:page />``:
  A page on the web, pointing to a `page template`_.

``<browser:viewlet />``:
  **Part** of a page, which also points at a `page template`_.

.. _static resource:

Static resources
----------------

Static resources are simply files with names, which are useful
for JavaScript, CSS, and images. When requested Zope sends the
static file to the browser.

The resource is defined by the ``<browser:resource/>`` directive
in the ZCML_.

.. code-block:: xml

     <browser:resource
       name="gs-group-messages-topic-compose-20160127.js"
       file="browser/javascript/compose.js"
       permission="zope2.Public" />

* The ``name`` attribute is the of the resource. The URL is made
  up of ``/`` and the name. Normally the name of the product
  (``gs.group.messages.topic`` in this case) makes up part of the
  name to prevent namespace clashes, and so it is easier to work
  back from the filename to the product. The name *should* end
  with the date the resource was created so there are fewer
  caching issues when the resource is updated.

* The ``file`` is the static file that is served. It is a path
  from the directory that holds the ZCML_ file. Resources are
  always within the ``browser`` sub-directory, within a
  ``javascript``, ``images`` or ``css`` directory.

* The ``permission`` is the permission on the resource. It is
  **always** ``zope2.Public``. This will allow the resource to be
  cached.

In GroupServer the resources are always accessed from the root of
the site, with ``++resource++`` added to the start of the name:
<http://groupserver.org/++resource++gs-group-messages-topic-compose-20160127.js>

.. index:: ZPT, Chameleon, Page templates

.. _page template:

Page Templates
--------------

Pages themselves are defined by one of two directives in the
ZCML_: ``<browser:page/>`` and ``<browser:viewlet/>``. The former
links the Python code (``class``) with a ``template``, giving it
a ``name``.

.. code-block:: xml

     <browser:page
       name="index.html"
       for="gs.group.base.interfaces.IGSGroupMarker"
       class="gs.group.base.page.GroupPage"
       template="browser/templates/homepage.pt"
       permission="zope2.View" />

A viewlet is **part** of a page. It also links a ``class`` up
with a ``name`` and ``template``.

.. code-block:: xml

     <browser:viewlet
       name="gs-group-message-topic-summary-stats"
       manager=".interfaces.ITopicSummary"
       template="browser/templates/summarystats.pt"
       class=".summarystats.SummaryStats"
       permission="zope2.View"
       weight="0"
       title="Topic Summary Statistics" />

The pages are created using `Zope Page Templates`_ (ZPT), which
is the same template system that Plone uses, and is very similar
to Chameleon_.

.. _Zope Page Templates: http://docs.zope.org/zope2/zope2book/ZPT.html

* The page templates are always stored in a directory called
  ``browser/templates``, within each product. Each has the
  extension ``.pt``.

* The template itself is **XHTML 5**: the XML form of HTML 5.

* The *dynamic* parts of the template are defined by
  **attributes**, using the Template Attribute Language
  (TAL). This accesses attributes and methods of the Python
  code. In the following example the group-name is written into
  the ``<h1/>`` element by the ``tal:content`` attribute.

    .. code-block:: xml

       <h1 id="gs-group-home-h" class="fn"
           tal:content="view/groupInfo/name">Group</h1>

* Within each attribute is one or more expressions that generates
  the text that is placed into the page. The Python code (the
  ``class`` in the ZCML above) is always referred to as ``view``,
  and a ``/`` is used as an attribute separator (rather than
  ``.`` in Python code). In the above example the Python class
  (``gs.group.base.page.GroupPage``) is accessed to get the
  group-information attribute (``groupInfo``), and from that the
  group-name is retrieved.

.. index:: reStructuredText

Documentation
=============

Every package will always have documentation. The primary
documentation is in the :file:`README.rst`, and there will also
be a Changelog in the :file:`docs/HISTORY.rst` file. Often there
will be full API documentation.

The development documentation for GroupServer_ is entirely in
reStructuredText_, with the autodoc_ plugin for Sphinx_ used to
generate the source-code documentation where possible. The
documentation is then usually pushed up to the `the GroupServer
project at Read The Docs`_; if it is then a link will be in the
:file:`README.rst`.

.. _autodoc: http://sphinx-doc.org/tutorial.html#autodoc
.. _the GroupServer project at Read The Docs:
   https://readthedocs.io/projects/groupserver/

..  _GroupServer: http://groupserver.org/
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Dan Randow: http://groupserver.org/p/danr
..  _Bill Bushey: http://groupserver.org/p/wbushey
..  _Alice Rose: https://twitter.com/heldinz
..  _E-Democracy.org: http://forums.e-democracy.org/
.. _GroupServer development: http://groupserver.org/groups/development/
.. _GitHub: https://github.com/groupserver
.. _PyPI: https://pypi.python.org/pypi/mr.developer/
.. _reStructuredText: http://sphinx-doc.org/rest.html
.. _Sphinx: http://sphinx-doc.org/
.. _SQLAlchemy: http://www.sqlalchemy.org/

.. [#novcs] I recommend that you use a local Mercurial repository
            on your local machine, rather than abandoning version
            control altogether.

..  LocalWords:  GitHub groupserver buildout VCS awk mr cfg Plone refactored
..  LocalWords:  SQL Namespaces namespace reStructuredText autodoc CSS ZCML ZPT
..  LocalWords:  TAL XHTML Changelog
