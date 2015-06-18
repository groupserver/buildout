===========================
Connecting external systems
===========================

:Authors: `Michael JasonSmith`_;
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2015-06-18
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International
  License`_ by `OnlineGroups.net`_.

..  _Creative Commons Attribution-Share Alike 4.0 International License:
    http://creativecommons.org/licenses/by-sa/4.0/

.. highlight:: console

------------
Introduction
------------

GroupServer_ provides *web hooks* that allow external systems to
access some features. All the hooks work the same way:

#. Data, including a token_ for authentication, is sent to a form
   as an HTTP ``POST``,
#. The system processes the request, and
#. Data is returned as a JSON_ object.

GroupServer uses some of these hooks itself, such as for adding
email (see :doc:`postfix-configure`) and sending out regular
notifications (see :doc:`cron`). Hooks are also provided to allow
external systems to manage the `profile life-cycle`_: creating,
retrieving, and removing profiles. These hooks all return the
same `profile data`_ as a JSON object.

Feel free ask any questions regarding the hooks in `GroupServer
Development`_ group.

:Note: The URLs used for web hooks are often quite long. This is
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

------------
Profile data
------------

The profile data returned by the hooks involved in the `profile
life-cycle`_ all return the same properties for the profiles,
either as a single JSON object, as part of a list, or as a
property of another object.

The profile-data includes the following five properties.

``id``:
  The identifier of the profile.

``name``:
  The name of the person.

``url``:
  The URL of the profile.

``groups``:
  A list of identifiers for the groups that the person is a
  member of.

``email``:
  The email addresses associated with the profile.

  * ``all``: All the addresses.
  * ``preferred``: The preferred address or addresses.
  * ``unverified``: The unverified addresses.
  * ``other``: The verified addresses that are not preferred.

Example profile data
====================

In the example JSON object below is the profile for someone
called ``A Person``. The have set a nickname, so the URL to the
profile does not contain their profile-identifier. They have two
email addresses, with their home address preferred and no
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

------------------
Profile life-cycle
------------------

The profile life-cycle follows 

* The creation of a profile when you `add a profile`_ to a group
  for the first time,
* Finding more about people when you `retrieve profile
  information`_, and finally
* The ending of a profile when you `remove a profile`_ from a
  group (or site).

Add a profile
=============



Retrieve profile information
============================

Remove a profile
================

..  _GroupServer: http://groupserver.org/
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _GroupServer development: http://groupserver.org/groups/development/
..  _JSON: http://json.org/
..  _PostgreSQL: http://www.postgresql.org/

..  LocalWords:  JSON webservice
