===========================
Configuring :command:`cron`
===========================

:Authors: `Michael JasonSmith`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2015-06-17
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 4.0 International License`_
  by `OnlineGroups.net`_.

..  _Creative Commons Attribution-Share Alike 4.0 International License:
    https://creativecommons.org/licenses/by-sa/4.0/

.. highlight:: console

------------
Introduction
------------

The :command:`cron` system needs to be configured to regularly
execute two commands that provide some GroupServer_
functionality. One provides the `daily digest of topics`_ to
those that elect to receive it. The other sends a `monthly
profile status`_ to everyone.

.. seealso:: `The Ubuntu Cron HOWTO`_ has more information on how
             to use :command:`cron`.

.. _The Ubuntu Cron HOWTO: https://help.ubuntu.com/community/CronHowto

----------------------
Daily digest of topics
----------------------

Group members can elect to receive a daily digest of topics. It
summarises the activity on the group on that day, which is an
excellent way to follow what is happening in a group without
being overwhelmed with email.

The :command:`cron` system needs to be configured to execute the
:command:`senddigest` command that sends out the digest::

  00 02 * * * /opt/groupserver/bin/senddigest http://groups.example.com/

The :manpage:`crontab(5)` example above will send the digests for
all the groups on the ``groups.example.com`` site, at 02:00
each day. It is recommended that the digests are sent out in the
early-hours of the morning, as this means they will contain the
activity for the full day.

.. note:: The full path to the :command:`senddigest` command in
          your GroupServer installation will be needed, as
          :envvar:`PATH` is not set for :command:`cron`.

The :command:`senddigest` command itself normally just takes the
URL of the site as its only argument. However, `the documentation
for the senddigest command`_ has more information about the
optional arguments, and running the command manually.

.. _the documentation for the senddigest command:
   https://groupserver.readthedocs.org/projects/gsgroupmessagestopicdigestsend/en/latest/command.html

----------------------
Monthly profile status
----------------------

Each month GroupServer can send out a personalised email to every
person that has a profile on the site and is a member of at least
one group. It summarises the activity in the groups, and provides
personalised suggestions about how the GroupServer experience can
be improved.

The :command:`cron` system needs to be configured to execute the
:command:`sendprofile` command that sends out the summary::

  0  11  1-7  *  *  /usr/bin/test $( date +\%u ) -eq 3 && \
    /opt/groupserver/bin/sendprofile -t1 http://groups.example.com/

The :manpage:`crontab(5)` example above will send the summary to
everyone on the ``groups.example.com`` site. The command will be
run at eleven in the morning of the *first Wednesday* of every
month. (I recommend that you send the notification in the middle
of the day in the middle of the week because it is more likely to
be read.)

`The documentation for the sendprofile command`_ details the
arguments. The ``-t1`` argument is used above to *throttle* the
:command:`sendprofile` command, slowing it down and allowing
other requests to be processed. This is important because, unlike
the `daily digest of topics`_, the monthly profile status is run
in the middle of the day when the site is likely to be busy, it
is intensive to process, and is unique for every recipient.

.. _The documentation for the sendprofile command:
   http://groupserver.readthedocs.org/projects/gsprofilestatussend/en/latest/script.html

.. _GroupServer: http://groupserver.org/
.. _GroupServer.org: http://groupserver.org/
.. _OnlineGroups.net: https://onlinegroups.net/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
