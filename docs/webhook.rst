===========================
Connecting external systems
===========================

:Authors: `Michael JasonSmith`_;
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2015-06-19
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

GroupServer_ provides *web hooks* that allow external programs to
access some features. All the hooks work the same way:

#. Data, including a token_ for authentication, is sent to a form
   as an HTTP ``POST``,
#. The system processes the request, and
#. The response is returned as a JSON_ object.

GroupServer uses some of these hooks itself — for tasks such as
for adding email (see :doc:`postfix-configure`) and sending out
regular notifications (see :doc:`cron`).

Here I first discuss the `authentication token`_. I then
introduce the hooks that are provided to allow external systems
to retrieve `group information`_ and manage the `profile
life-cycle`_: creating, retrieving, and removing profiles.

Feel free ask any questions regarding the hooks in `GroupServer
Development`_ group.


.. note::
       The URLs used for web hooks are often quite long. This is
       deliberate, as it makes them easy to spot, and easier to
       understand as they refer to the GroupServer subsystem that
       provides the functionality.

.. _token:

--------------------
Authentication token
--------------------

**All** the web-hooks require the ``token`` parameter to be sent
when an HTTP ``POST`` is made to the hook. The value of this
token is written down in the :file:`etc/gsconfig.ini` file, as
the ``token`` parameter for the ``webservice`` section of the
configuration.

A unique token is created when you install GroupServer. It is
*very important* that you keep this token **secret**. If the
token accessed by a nefarious individual then they can do
**extensive harm** your site.

However, all is not lost `if the token is exposed`_, as you can
generate a new token.

.. warning::
   Because consequence of the token being divulged is so high it
   is recommended that the hooks are only used from the same
   machine as GroupServer (so it never travels over a network),
   or using **secure connections** (TLS).

If the token is exposed
=======================

**Generate a new token** if the token used to authenticate the
web hooks is exposed.

#. Run the :program:`gs_auth_token_create` program, in the
   ``bin`` directory of your GroupServer install.

   * It takes a data-source name (DSN) as its only argument,
     identifying the PostgreSQL_ database to connect to.
   * The DSN for your GroupServer site is listed as the ``dsn``
     parameter for the ``database`` section of the configuration
     in the :file:`etc/gsconfig.ini` file.

#. The :program:`gs_auth_token_create` program will

   * **Generate** a new token, and
   * **Change** the value of the token in the PostgreSQL
     database.

   At this point the token in the PostgreSQL database and the
   :file:`etc/gsconfig.ini` file will be different, so *all web
   hooks* will be **broken**. This includes the hook that used by
   the :program:`smtp2gs` program, which adds email messages to
   the site.

#. The :program:`gs_auth_token_create` program reports the new
   token. **Edit** :file:`etc/gsconfig.ini` and **change** the
   ``token`` parameter in the ``webservice`` section. **Save**
   the file. All web hooks will be running again. No restart of
   GroupServer is necessary to change the token.

:See also: `The documentation at Read the Docs`_ contains more
           details about the :program:`gs_auth_token_create`
           program.

.. _The documentation at Read the Docs:
     http://groupserver.readthedocs.org/projects/gsauthtoken/en/latest/script.html


-----------------
Group information
-----------------

The web hook ``/gs-group-groups.json`` is the simplest
web-hook. It takes the `authentication token`_ (``token``) and
the action (``get``) — and it returns a list of group-objects.

.. seealso:: `The documentation for the Groups web-hook`_ has
             more details about how the hook works, including
             examples.

.. _The documentation for the Groups web-hook:
   http://groupserver.readthedocs.org/projects/gsgroupgroupsjson/en/latest/hook.html

------------------
Profile life-cycle
------------------

There are web-hooks for managing the entire life-cycle of a profile.

* Create a profile when you `add a profile`_ to a group for the
  first time,
* Find more about people when you `retrieve profile
  information`_.
* Finally, you can `remove a profile`_ from a group (or site).

Most of the profile-related web hooks return the same `profile
data`_.

Profile data
============

The profile data returned by the hooks involved in the `profile
life-cycle`_ all return the same properties for the profiles,
either as a single JSON object, as part of a list, or as a
property of another object.

.. js:class:: ProfileData()

   The profile-data includes the following five properties.

   .. js:attribute:: id

      The identifier of the profile.

   .. js:attribute:: name

      The name of the person.

   .. js:attribute:: url

      The URL of the profile.

   .. js:attribute:: groups

      A list of identifiers for the groups that the person is a
      member of.

   .. js:attribute:: email

      The email addresses associated with the profile.

      .. js:attribute:: all

         A list of all the email addresses.

      .. js:attribute:: preferred

         A list of the preferred address or addresses.

      .. js:attribute:: other

         A list of verified addresses that are not preferred.

      .. js:attribute:: unverified

         A list of the unverified addresses.

Example profile data
--------------------

In the example JSON object below is the profile for someone
called ``A Person``. The have set a nickname, so the URL to the
profile does not contain their profile-identifier. They have two
email addresses — with their home address preferred, and no
unverified addresses. Finally, the person belongs to two groups:
Example, and Test.

 .. code-block:: json

   {
      "id": "qK7SgjsTHcLNrJ2ClevcJ0",
      "name": "A Person",
      "url": "https://groups.example.com/p/aperson",
      "email": {
        "all": [
          "a.person@home.example.com",
          "a.person@work.example.com"
        ],
        "preferred": [
          "a.person@home.example.com"
        ],
        "other": [
          "a.person@work.example.com"
        ],
        "unverified": []
      },
      "groups": [
        "example",
        "test"
      ]
    }

Add a profile
=============

The web-hook ``/gs-group-member-add.json`` is used to add a
profile to a group. It will also create a profile, if one does
not exist for that person already. The hook takes

* The `authentication token`_ (``token``),
* A name (``fn``),
* an email address (``email``),
* A group identifier (``groupId``), and
* An action (``add``).

It returns the `profile data`_ of the person that has been added
to the group, as well as some details about whether a profile was
created, or already existed.

.. seealso:: `The documentation for the Add a profile web-hook`_
             has more details about how the hook works, including
             examples.

.. _The documentation for the Add a profile web-hook:
   http://groupserver.readthedocs.org/projects/gsgroupmemberaddjson/en/latest/hook.html

Retrieve profile information
============================

There are three ways to retrieve profile information: information
about `an individual`_, and information about `people that belong
to a site`_.

.. _an individual:

Single profile
--------------

The web-hook ``/gs-search-people.json`` allows you to retrieve
information about an individual, using their user-identifier or
email address. The hook takes

* An `authentication token`_,
* The identifying information about someone (``user``) — which is
  either the user-identifier or email address), and
* An action (``search``).

It returns the `profile data`_ of the person, or an empty object
(``{}``) if no one could be found.

.. seealso:: `The documentation for the Search for people
             web-hook`_ has more details about how the hook
             works, including examples.

.. _The documentation for the Search for people web-hook:
   http://groupserver.readthedocs.org/projects/gssearchpeople/en/latest/hook.html

.. Group members
.. -------------

.. _people that belong to a site:

Site members
------------

The web-hook ``/gs-site-member.json`` allows you to retrieve
information about the site members in a couple of ways.

* If passed an `authentication token`_ and an action of ``users``
  then a simple list of user-identifiers is returned.
* If passed an `authentication token`_ and an action of
  ``user_groups`` then the full `profile data`_ is returned for
  each person.

.. seealso:: `The documentation for the Site members web-hook`_
             has more details about how the hook works, including
             examples.

.. _The documentation for the Site members web-hook:
   http://groupserver.readthedocs.org/projects/gssitememberjson/en/latest/hook.html

Remove a profile
================

The web-hook ``/gs-group-member-leave.json`` removes a person
from a group. The hook takes

* The `authentication token`_ (``token``),
* A group identifier (``groupId``), and
* A user-identifier (``userId``).

.. seealso:: `The documentation for the Leave group web-hook`_
             has more details about how the hook works, including
             examples.

If you only have an email-address for the person, then you should
retrieve a `single profile`_ first to determine the user
identifier (:js:attr:`id`).

The profile is also useful for removing someone from a
**site**. A person is removed from a site when they are removed
from all groups on the site: so by iterating through the list of
groups (:js:attr:`groups`) you will eventually remove someone
from the site.

.. _The documentation for the Leave group web-hook:
   http://groupserver.readthedocs.org/projects/gsgroupmemberleave/en/latest/hook.html

..  _GroupServer: http://groupserver.org/
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _GroupServer development: http://groupserver.org/groups/development/
..  _JSON: http://json.org/
..  _PostgreSQL: http://www.postgresql.org/

..  LocalWords:  JSON webservice
