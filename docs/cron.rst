================
Configuring cron
================

:Authors: `Michael JasonSmith`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2014-11-17
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

.. highlight:: console

Group members can elect to receive a daily digest of topics. The
:command:`cron` system will need to be configured to execute the
:command:`senddigest` command that will send out this digest::


  00 02 * * * /opt/groupserver/bin/senddigest http://groups.example.com/

The :manpage:`crontab(5)` example above will send the digests for
``groups.example.com`` out at 02:00 each day. It is recommended
that the digests are sent out in the early-hours of the morning,
as this means they will contain the activity for the full
day. The :command:`senddigest` command itself normally just takes
the URL of the site as its only argument.


:Note: The full path to the :command:`senddigest` command in your
       GroupServer installation will be needed, as :envvar:`PATH`
       is not set for :command:`cron`.

:See also: The `Ubuntu Cron HOWTO`_ has more information on how
           to use :command:`cron`.

.. _GroupServer: http://groupserver.org/
.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.net: https://onlinegroups.net/
..  _Postfix: http://www.postfix.org/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Creative Commons Attribution-Share Alike 4.0 International License:
    http://creativecommons.org/licenses/by-sa/4.0/
.. _Ubuntu Cron HOWTO: https://help.ubuntu.com/community/CronHowto
