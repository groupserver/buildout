--------------------------------------------------------
GroupServer 10.12 — Lemon Ice in the Cool of the Evening
--------------------------------------------------------

:Authors: Michael JasonSmith; Richard Waid; Alice Rose; Dan Randow
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2010-12-17
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

.. index::
   pair: JavaScript; jQuery

The Lemon Ice release of GroupServer mostly consists of changes to the
CSS. 

* New layout, based on the layout of `OnlineGroups.net`_.
* Two new color schemes (skins):

  #. Blue, based on `the E-Democracy.org Forums`_
  #. Green, based on `OnlineGroups.Net`_

* *Fit and finish* work to improve the look of GroupServer.
* Integration of the jQuery.UI code into the default CSS.

Work is now starting on GroupServer 11.01 — Baked Alaska with an Eye
on the Soviets.

Update an Existing GroupServer System
=====================================

To update an existing GroupServer system to Lemon Ice you will have to
`update the package versions`_. To use the new skins you will have to
`update the virtual hosting`_.

Update the Package Versions
---------------------------

Carry out the following steps to update the package versions.

#. Download the Lemon Ice tar-ball from `the GroupServer download page 
   <http://groupserver.org/downloads>`_

#. Uncompress the tar-ball.
   
#. Copy the file ``groupserver-10.12/versions.cfg`` to your existing
   GroupServer installation.
   
#. In your existing GroupServer installation run::

      $ ./bin/buildout -N

Update the Virtual Hosting
--------------------------

The virtual hosting will need to be updated in order to use the new 
skins. Without the new skins the default black-and-white color scheme will be shown. By default Zope is set up to provide the virtual hosting. To change the Zope setup carry out the following

#. Log into the ZMI for your site.
#. Select ``virtual_hosting``. You should see the page for the Virtual
   Host Monster.
#. Select the ``Mappings`` tab. You should see a line that starts with
   the name of your site (``gstest`` by default) that is followed path
   to the site (``/example/Content/example_site/``).
#. Add ``++skin++gs_blue`` to the end of the path for the blue skin.
   Alternatively add ``++skin++gs_green`` for the green skin.
#. Click the *Save Changes* button.
#. Visit the homepage your site (<http://gstest/> by default).
#. Reload the page. You may need to hold down ``Shift`` when clicking 
   the Reload button to ensure you reload the CSS.

.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.Net: https://onlinegroups.net/
.. _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
   http://creativecommons.org/licenses/by-sa/3.0/nz/
.. _GroupServer Development: http://groupserver.org/groups/development
.. _the E-Democracy.Org Forums: http://forums.e-democracy.org

