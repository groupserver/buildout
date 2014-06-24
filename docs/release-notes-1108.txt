===============================================================
GroupServer 11.08 — Banana Split Eaten in a Comfortable Silence
===============================================================

:Authors: `Michael JasonSmith`_; `Richard Waid`_; `Dan Randow`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2011-08-31
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

Introduction
============

The main update that is present in the Banana release of GroupServer is
a `Facebook signup`_ system. You can `get Banana Split`_ immediately. 

Acknowledgements
----------------

Thanks to `Steven Clift`_ for his support for the `Facebook signup`_
system.

Facebook Signup
===============

Previously, new members had to provide all their profile information
during signup. Now new members have the option of logging into
Facebook_ to retrieve the profile information. Signing up using
Facebook is beneficial in two ways.

#.  The email address of the new member does not have to be verified, as
    Facebook has already verified the address. This reduces the number
    of steps required for sign-up from three to two.

#.  Much of the profile information does not have to be added, as it
    is copied in from Facebook.

The new member has a choice to use the older signup system that
just uses email, or the new Facebook signup. The latter option
is automatically available after the administrator has `setup`_
Facebook signup.

Setup
-----

You must acquire two values from Facebook to enable Facebook Signup.

Application ID Value
  This is the identifier for your Facebook *application*.
  
Application Secret Value
  This is the secret key that is passed from your site to Facebook.
  
To get these values you will need to register your site as an
*application* with Facebook. Do this by visiting
<https://developers.facebook.com/> and following the instructions. 
Facebook will then supply you with an ``App ID`` and ``App Secret``. 
Once you have these you can carry out the following tasks.

#.  Log into the PostgreSQL database used GroupServer by using the
    following command::

      $ psql -Upgsql_user pgsql_dbname  

    Note that ``pgsql_user`` and ``pgsql_dbname`` are the database user
    and database name that were set during installation. Both can be
    found in the ``instance.cfg`` file in the installation directory
    of GroupServer.
   
#.  Run the following SQL to add the ``App ID`` and ``App Secret``
    to the ``options`` table::

      INSERT INTO option 
      VALUES (
        'gs.profile.signup.facebook',
        'app_id',
        NULL,
        NULL,
        App ID
      );

      INSERT INTO option 
      VALUES (
        'gs.profile.signup.facebook',
        'app_secret',
        NULL,
        NULL,
        App Secret
      );
    
    Note the ``App ID`` and ``App Secret`` in the above SQL are the
    values provided by Facebook. Both values will need to be in quotes.

Once the data is in the ``options`` table the Sign Up page will 
automatically show the option to sign up using Facebook.

Get Banana Split
================

To get Banana Split go to `the Downloads page for GroupServer`_ and
follow `the GroupServer Installation documentation`_. Those who already
have a functioning installation can `update an existing GroupServer
system`_.


Update an Existing GroupServer System
-------------------------------------

To update an existing GroupServer system to Banana Split carry out
the following steps.

#.  Download the Banana Split tar-ball from `the GroupServer download 
    page <http://groupserver.org/downloads>`_.

#.  Uncompress the tar-ball.
   
#.  Copy the file ``groupserver-11.08/versions.cfg`` to your existing
    GroupServer installation.
   
#.  Copy the file ``groupserver-11.08/buildout.cfg`` to your existing
    GroupServer installation.

#.  In your existing GroupServer installation run::

      $ ./bin/buildout

..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
    http://creativecommons.org/licenses/by-sa/3.0/nz/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Richard Waid: http://groupserver.org/p/richard
..  _Dan Randow: http://groupserver.org/p/danr
..  _Steven Clift: http://groupserver.org/p/stevenc
..  _Facebook: https://www.facebook.com/
..  _The Downloads page for GroupServer: http://groupserver.org/downloads
..  _The GroupServer Installation documentation: 
    http://groupserver.org/downloads/install

