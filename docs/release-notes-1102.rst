-----------------------------------------------------
GroupServer 11.02 — Tartufo Nibbled in Polite Company
-----------------------------------------------------

:Authors: Michael JasonSmith; Richard Waid; Alice Rose; Dan Randow
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2011-02-28
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

The Tartufo release of GroupServer mostly consists of enhancements so
errors are handled better.

.. index::
   pair: JavaScript; jQuery

* A new *Unexpected Error* page provides more detail to the user.
  In addition, the pre-written message to support contains a full
  stack-trace. This information can be used to find and eliminate the
  error [#UnexpectedError]_.
* Many errors were generated when non-existent pages were accessed. 
  These errors have been fixed, primarily in the mailing-list
  code. This should make problems recorded in the error-log maintained
  by Zope easier to find, as there should be fewer items in the log
  [#Traversal]_.
* Changes to email addresses are now better recorded [#EmailAudit]_.
  This should help diagnose problems better if there is an error
  subsequent to an address changing.
* The jQuery code shipped with GroupServer has been updated to the
  latest stable version (1.4.4).
* The code that generates the image, post, and topic pages has been
  refactored. This should make those pages easier to maintain.
  
Work is now starting on GroupServer 11.03 — Pineapple Snow at a
Child's Party.

Update an Existing GroupServer System
=====================================

Carry out the following steps to update the package versions.

#. Download the Tartufo tar-ball from `the GroupServer download page
   <http://groupserver.org/downloads>`_

#. Uncompress the tar-ball.
   
#. Copy the file ``groupserver-11.02/versions.cfg`` to your existing
   GroupServer installation.
   
#. In your existing GroupServer installation run::

      $ ./bin/buildout -N

.. [#UnexpectedError] The new Unexpected Error page is detailed in
   `a post to GroupServer Development
   <http://groupserver.org/r/post/66XZLJkEax3zuXdFQhJ6zU>`_.
.. [#Traversal] The *traversal* errors were those caused by not handling
   errors that were thrown by pages in the messages, profile, and files 
   area.
.. [#EmailAudit] Recording more information about email addresses 
   changing closes `Ticket 432 <https://redmine.iopen.net/issues/432>`_.
     
.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.Net: https://onlinegroups.net/
.. _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
   http://creativecommons.org/licenses/by-sa/3.0/nz/

