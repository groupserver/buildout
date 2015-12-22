=============================================
GroupServer 14.06 — Slivovica shots at sunset
=============================================

:Authors: `Michael JasonSmith`_; 
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2014-06-03
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

.. highlight:: console

------------
Introduction
------------

The major `changes to GroupServer`_ in the Slivovica release
include making the system easier to install, better at handling
email, and improving the reliability. You can `get Slivovica`_
immediately.

----------------------
Changes to GroupServer
----------------------

For new installations of GroupServer_ the most important change
is the `updated buildout recipes`_, that should make the process
of installing GroupServer more robust. For existing systems
`DMARC support`_ has been added, as well as improvements to how
`incoming SMTP`_ is handled. Finally there have been many other
`minor code improvements`_.

.. index::
   pair: Install; Build

Updated buildout recipes
========================

GroupServer itself is installed using four *recipes* that are
used by Buildout_. All four recipes have been improved. There is
now a base recipe *class* that is shared by the recipes, and
unit-tests have been added to ensure the recipes work as
expected. Specific improvements include the following.

* The recipe that creates the Postfix configuration has been
  updated, fixing `a problem that Bill found`_.
* The recipe that crates the PostgreSQL tables now uses the
  `setuptools`_ package to extract the SQL files from the
  different modules. The modules are now passed into the recipe
  from Buildout, rather than being written in the recipe.
* The creation of the GroupServer site is now simpler, as only
  the site-administrator is created during installation. This
  solves many issues with the email-address of the normal
  group-member conflicting with the email address of the site
  administrator.

.. _Buildout: http://www.buildout.org/en/latest/
.. _a problem that Bill found: http://groupserver.org/r/post/3mqbXmGwp6CqQWBkCjPXQI
.. _setuptools: https://pypi.python.org/pypi/setuptools/

.. index::
   pair: Email; DMARC

DMARC Support
=============

With the Slivovica release of GroupServer messages are more
likely to be received by people whose email is provided by hosts
that implement `strict DMARC`_. With strict DMARC messages are
checked to ensure that message was actually sent from the host
listed in the ``From`` address. All mailing-lists (including GNU
Mailman, Google Groups, and Yahoo!  Groups) modify the message
before sending it out, and this would cause the DMARC check to
fail.

Like most other mailing lists, GroupServer now rewrites the
``From`` address if the group member uses an email provider that
implements strict DMARC. The new address includes the name of the
sender, and the ID of his or her profile (see `Feature
4108`_). This ensures that the person who sent the message can
still be identified, and email message will still get through.

.. _strict DMARC: http://groupserver.org/r/topic/3x4yEy0lBQnHuROtR4Kwnx
.. _Feature 4108: https://redmine.iopen.net/issues/4108

.. index::
   pair: Email; SMTP

Incoming SMTP
=============

With the Slivovica release of GroupServer email messages are
correctly sent to GroupServer when it is running on a
non-standard port. Messages are received by Postfix, which then
uses the ``smtp2gs`` programme to add the message to
GroupServer. Previously manual intervention was needed if
GroupServer was listening to a non-standard port.

Now all components of GroupServer correctly handle the port that
is set in the configuration file when GroupServer is first
set-up. This includes the *recipe* that creates the alias file
for Postfix, the ``smtp2gs`` script that uploads the email
message, and the ``gs.form`` library that ``smtp2gs`` uses to
connect to GroupServer.

Minor code improvements
=======================

Four components have undergone minor updates for Slivovica.

Add member:
  Fixed an error with the dependencies of the product that added
  a member to a group.

Site style:
  Some errors in the CSS have been fixed.

``mbox`` importing:
  The code that imports ``mbox`` files has been updated, and it
  now uses the same core code as the ``smtp2gs`` script.

Starting public groups:
   Public groups are now visible on the homepage of the site as
   soon as they are started, closing `Bug 4105`_.

.. _Bug 4105: https://redmine.iopen.net/issues/4105

In addition the following general changes have been made to
GroupServer.

* Three fundamental *products* — `gs.core`_, `gs.dmarc`_, and
  `gs.form`_ — have been **published** to PyPI.
* Sphinx_ is now used to generate the **documentation** for
  ``gs.config``, ``gs.core``, ``gs.database``, ``gs.dmarc``,
  ``gs.form``, and ``gs.group.messages.add.smtp2gs``.
* **Unit tests** have been added to many of the products that
  make up GroupServer. These tests make it more likely that these
  components that make up GroupServer will work correctly now and
  in the future.
* Where possible **Python 3 support** has been added to the
  products that make up GroupServer. The main change has been to
  switch to Unicode-text by default. While not all products have
  been updated, many have.
* **Strict mode** has been turned on in more of the JavaScript
  modules that support the GroupServer interface. Code written
  with strict-mode turned on is more likely to be correct, and is
  executed more quickly in modern browsers.
* Finally, more code now raises errors, rather than relying on
  ``assert`` statements. As these errors should never happen
  hopefully no-one will notice a difference.

.. _Sphinx: http://sphinx-doc.org/
.. _gs.core: https://pypi.python.org/pypi/gs.core/
.. _gs.dmarc: https://pypi.python.org/pypi/gs.dmarc/
.. _gs.form: https://pypi.python.org/pypi/gs.form/

-------------
Get Slivovica
-------------

To get Slivovica go to `the Downloads page for GroupServer`_ and
follow `the GroupServer Installation documentation`_. Those who
already have a functioning installation can `update an existing
GroupServer system`_.

..  _The Downloads page for GroupServer: http://groupserver.org/downloads
..  _The GroupServer Installation documentation: http://groupserver.org/downloads/install

Update an Existing GroupServer System
=====================================

To update a system running the Ouzo release of GroupServer
(14.03) to Slivovica (14.06) carry out the following steps.

#.  Download the Slivovica tar-ball from `the GroupServer
    download page <http://groupserver.org/downloads>`_.

#.  Uncompress the tar-ball::

      $ tar cfz groupserver-14.06.tar.gz

#.  Change to the directory that contains your existing
    GroupServer installation.

#.  Copy the new version-configuration files to your existing
    GroupServer installation::

      $ cp ../groupserver-14.06/[vz]*cfg  .

#.  In your existing GroupServer installation run::

      $ ./bin/buildout -n

#.  Restart your GroupServer instance.

---------
Resources
---------

- Code repository: https://source.iopen.net/groupserver/
- Questions and comments to http://groupserver.org/groups/development
- Report bugs at https://redmine.iopen.net/projects/groupserver

..  _GroupServer: http://groupserver.org/
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Creative Commons Attribution-Share Alike 4.0 International License:
    http://creativecommons.org/licenses/by-sa/4.0/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Dan Randow: http://groupserver.org/p/danr
..  _Bill Bushey: http://groupserver.org/p/wbushey
..  _E-Democracy.org: http://forums.e-democracy.org/

..  LocalWords:  refactored iopen JPEG redmine jQuery jquery async
..  LocalWords:  Randow Organization sectnum Slivovica DMARC CSS
..  LocalWords:  SMTP smtp
