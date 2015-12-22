.. index::
   single: Proxy
   single: Web proxy
   pair: Install; Proxy
   pair: Configuration; Proxy

=======================
Configuring a web proxy
=======================

:Authors: `Michael JasonSmith`_; `Fabien Hespul`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2015-02-12
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

..  _Creative Commons Attribution-Share Alike 4.0 International License:
    https://creativecommons.org/licenses/by-sa/4.0/

.. highlight:: console

Introduction
============

While GroupServer_ *can* run as a stand-alone web-server, it is
**highly recommended** that a proxy is used when making the site
available to the public to provide the following services:

* To mediate between the low level HTTP port (port 80) and the
  high-port that Zope runs on (normally port 8080).
* To rewrite the URL to include a skin directive.
* To rewrite the URL to support virtual hosting.
* To provide caching.
* To provide a secure connection.

In this document we explain how to `add a virtual host`_ to
either Apache_ or nginx_, and how to `change the reported port`_
in GroupServer. We then explain how to `change the skin`_, before
we outline how to set up `secure connections`_.

.. note:: You will need to be the root user to carry out most of
          these tasks. Commands that need to be run as root will
          be shown with ``#`` prompt, rather than a ``$``.

.. index::
   single: Virtual host

Add a virtual host
==================

If you have a new domain [#domain]_ that you want to use with
your GroupServer installation first you must `update the
GroupServer configuration`_ and then `add a virtual host to
Apache`_ or `Add a virtual host to nginx`_.

.. _GroupServer Name:

.. index::
   pair: Configuration; GroupServer

Update the GroupServer configuration
------------------------------------

If you used a host such as ``gstest`` to try out GroupServer then
you will need to update the configuration for GroupServer itself.

#.  Log into the ZMI (see :ref:`ZMI Login`).

#.  Visit the folder for your site at
    :menuselection:`groupserver --> Contents --> initial_site`.

#.  Open the :guilabel:`DivisionConfiguration` object.

#.  Set the :guilabel:`canonicalHost` to the domain for your new
    site.

#.  Set the :guilabel:`canonicalPort` to ``80``.

#.  Click the :guilabel:`Save Changes` button.

.. index::
    pair: Configuration; Apache

Add a virtual host to Apache
----------------------------

To add a virtual host to Apache carry out the following steps.

#.  Ensure the ``rewrite``, ``proxy``, and ``proxy_httpd``
    modules are enabled in Apache:

      .. code-block:: console

        # a2enmod rewrite proxy proxy_http
        # service apache2 restart

#.  Open :file:`/etc/apache2/sites-available/groupserver` in a
    text-editor.

#.  Add the following to the file

      .. code-block:: apacheconf

        <VirtualHost *:80>
          ServerAdmin support@example.com
          ServerName groups.example.com

          RewriteEngine on
          RewriteRule ^/(.*) http://localhost:8080/groupserver/Content/initial_site/VirtualHostBase/http/%{HTTP_HOST}:80/VirtualHostRoot/$1 [L,P]

          ProxyVia On

          ErrorLog ${APACHE_LOG_DIR}/error.log

          # Possible values include: debug, info, notice, warn, error, crit,
          # alert, emerg.
          LogLevel info

          CustomLog ${APACHE_LOG_DIR}/access.log combined
        </VirtualHost>

    * Change the address for the site from ``groups.example.com``
      to that of you new virtual host.

    * Change the email address for ``ServerAdmin`` from
      ``support@example.com`` to the value of the
      ``support_email`` in the ``config.cfg`` file in the
      GroupServer directory.

#.  Link the configuration for your host:

      .. code-block:: console

        # cd /etc/apache2/sites-enabled/
        # ln -s ../sites-available/groupserver 100-groupserver

#.  Restart Apache using :command:`service`

      .. code-block:: console

        # service apache2 restart

.. index::
    pair: Configuration; nginx

Add a virtual host to nginx
---------------------------

Open :file:`/etc/nginx/sites-avaliable/groupserver` in a
text-editor.

#.  Add the following to the file

      .. code-block:: nginx

        upstream gs {
          server localhost:8080;
        }

        server {
          listen 80;
          server_name groups.example.com;

          location / {
            rewrite /(.*) /VirtualHostBase/http/$host:80/groupserver/Content/initial_site/VirtualHostRoot/$1 break;
            proxy_pass http://gs/;
            include proxy_params;
          }
        }

        server {
          listen 80;
          server_name zmi.groups.example.com;

          location / {
            rewrite /(.*) /VirtualHostBase/http/$host:80/VirtualHostRoot/$1 break;
            proxy_pass http://gs/;
            include proxy_params;
          }
        }

    * Change the ``server_name`` from ``groups.example.com`` to
      that of you new virtual host.

    * Make a similar change to the second server, keeping the
      ``zmi.`` at the start.

#.  Link the configuration for your host:

      .. code-block:: console

        # cd /etc/nginx/sites-enabled/
        # ln -s ../sites-available/groupserver 100-groupserver

#.  Reload the nginx configuration using :command:`service`:

      .. code-block:: console

        # service nginx reload

Change the reported port
========================

Notifications from GroupServer (such as the *Welcome* email to a
new group member) normally contain links back to the site. These
links will reference the port that was used when GroupServer was
built (``8080``) rather than the new HTTP or HTTPS port provided
by the proxy. To change the port that GroupServer *says* it is
using carry out the following tasks.

#.  Connect to the ZMI for your site.
#.  Visit the folder for your site, at
    :guilabel:`groupserver/Content/initial_site`.
#.  Open the :guilabel:`DivisionConfiguration` object.
#.  Select the check-box next to the :guilabel:`canonicalPort`
    line.
#.  Click the :guilabel:`Delete` button. The
    :guilabel:`canonicalPort` value will be deleted.

.. note:: In the unlikely case that a non-standard port is used,
          change the value of the ``canonicalPort`` and click the
          *Save changes* button, rather than deleting the
          property.

.. index:: !Skin, Theme

Change the skin
===============

One of the advantages of adding a proxy is it allows the skin to
be easily changed. GroupServer ships with two skins: green and
blue. To change the skin you must alter the rewrite rule. In the
case of nginx the rewrite rule will look like the following

.. code-block:: nginx

  rewrite /(.*) /++skin++gs_blue/VirtualHostBase/http/$host:80/groupserver/Content/initial_site/VirtualHostRoot/$1 break;

In the case of Apache the rewrite rule would look like the following

.. code-block:: apache

  RewriteRule ^/(.*) http://localhost:8080/++skin++gs_green/groupserver/Content/initial_site/VirtualHostBase/http/%{HTTP_HOST}:80/VirtualHostRoot/$1 [L,P]

.. index:: HTTPS, !TLS, SSL

.. _secure connections:

Secure connections: TLS, SSL, and HTTPS
=======================================

Setting up a secure connection is done in two stages. First you
:ref:`set up your proxy <proxy HTTPS>`, then you :ref:`configure
GroupServer <GroupServer HTTPS>`.

.. _proxy HTTPS:

.. index::
   pair: Configuration; nginx

Update the proxy configuration
------------------------------

Establishing a secure connection is done by the proxy rather than
GroupServer itself. The proxy should still listen to port 80
(HTTP) and make a permanent redirect to the secure site by
returning a ``301`` response. In nginx the rule would look like
the following:

.. code-block:: nginx

  server {
    listen 80;
    server_name groups.example.com;

    return 301 https://$server_name$request_uri;
  }

The proxy will also listen to the secure port and perform a
rewrite to your GroupServer site. This is similar to the rewrite
when you `add a virtual host`_, but

* There is configuration for the SSL certificates,
* The port is 443, rather than 80, and
* The protocol is ``https`` rather than ``http``.

.. code-block:: nginx

  server {
    listen 443;
    server_name groups.example.com;

    ssl on;
    ssl_certificate /etc/nginx/ssl/groups.example.com.crt;
    ssl_certificate_key /etc/nginx/ssl/groups.example.com.key;

    location / {
      rewrite /(.*) /VirtualHostBase/https/$host:443/groupserver/Content/initial_site/VirtualHostRoot/$1 break;
      proxy_pass http://gs/;
      include proxy_params;
    }
  }

You can `change the skin`_ in the rewrite rule, just like before.

.. _GroupServer HTTPS:

.. index::
   pair: Configuration; GroupServer

Update GroupServer
------------------

GroupServer should use ``https`` links in email messages and in
the :guilabel:`Share` button [#web]_, to prevent potential
attacks. To do this carry out the following tasks.

#.  Log into the ZMI (see :ref:`ZMI Login`).
#.  Visit the folder for your site at
    :menuselection:`groupserver --> Contents --> initial_site`.
#.  Select the :guilabel:`DivisionConfiguration` object.
#.  Set the :guilabel:`canonicalPort` to ``443``.
#.  Select the :guilabel:`useHTTPS` check-box (the one to the
    right, sorry it *is* confusing).
#.  Click the :guilabel:`Save Changes` button.

.. [#domain] Acquiring and configuring a new domain is out of the
             scope for this documentation. However, you want the
             A-record for your new domain to point to the IP of
             your GroupServer site, and the MX-record to also
             point at your new site.

.. [#web] On the web GroupServer normally uses links without a
          specified protocol.

..  _GroupServer: http://groupserver.org/
..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.net: https://onlinegroups.net/
..  _Apache: http://httpd.apache.org/
..  _nginx: http://nginx.org/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Fabien Hespul: http://groupserver.org/p/1e38zikXDqFgXFkmCjqC31

..  LocalWords:  TLS DivisionConfiguration apache groupserver params SSL
