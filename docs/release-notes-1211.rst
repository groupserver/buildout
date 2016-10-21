=================================================
GroupServer 12.11 — Absinthe acquired arbitrarily
=================================================

:Authors: `Michael JasonSmith`_; `Richard Waid`_; `Dan Randow`_
:Contact: Michael JasonSmith <mpj17@onlinegroups.net>
:Date: 2012-11-12
:Organization: `GroupServer.org`_
:Copyright: This document is licensed under a
  `Creative Commons Attribution-Share Alike 3.0 New Zealand License`_
  by `OnlineGroups.Net`_.

.. contents::

------------
Introduction
------------

There are fourteen major changes to GroupServer in the Absinthe
release — making the system more useful, usable and extensible
for both group members, administrators, and developers.

The `changes visible to participants`_ are mostly subtle
improvements to existing features, rather than new features. In
contrast, the `changes to the underlying system`_ are complex and
extensive.

You can `get Absinthe`_ immediately.

Acknowledgements
================

Thanks to `Bill Bushey`_, with the support of `E-Democracy.org`_, for the
improvements to the `SVG thumbnails`_. Thanks to Bill and `Marek Kuziel`_
for testing some early versions of Absinthe.

-------------------------------
Changes visible to participants
-------------------------------

The most visible change for the participants is a `new search
system`_.  Some `better error pages`_ have also been created. To
help participants and administrators there is a `new help
system`_, while an `in-context administration guide`_ will help
administrators get their new group going more
easily. Administrators now have the ability to create `closed
groups`_, and the new `profile search`_ will help administrators
find the profiles of participants. Finally, `SVG thumbnails`_ are
now shown.

.. index:: !Search
   pair: Topic; Keywords
   pair: Topic; Search
   pair: Post; Search
   pair: Email; Search

New search system
=================

The new search system is the most visible change in Absinthe.

* The *Topics* tab on both the site homepage and the group page have a
  *Search* entry [#noSearch]_.
* The *Posts* tab in a group has as *Search* entry also, allowing posts to
  be searched [#postSearch]_.
* Clicking a topic keyword will search for other topics with that keyword
  [#clickableKW]_.
* Searching now uses *stems*; searching for ``search`` will match topics
  that contain the words ``searches``, ``searching`` or ``searched``, for
  example.
* Searching is faster, as the full-text retrieval features of PostgreSQL_
  are used [#FTR]_.
* The display of topics in a site or group is much faster, as the keywords
  are now generated when someone posts, rather than when the topic is
  loaded.
* Searching using non-ASCII characters now works [#nonAscii]_.

Better error pages
==================

The *Permission Denied* page has been improved to add some suggestions
about what the participant should do [#forbidden]_. In addition the
``mailto`` that is embedded in the page now includes the URL of the problem
page in the body of the email message to the Support address.

The Unexpected Error (500) page and the Not Found (404) page now work with
``infrae.wsgi``, for systems that run GroupServer behind a WSGI
front-end. Neither of these error-pages redirect to display the error.

New help system
===============

The old monolithic manuals have been replaced. The new more dynamic system
will automatically show help for the features that are installed in
GroupServer, including the custom features. Some of the old pages have been
retained and updated.

.. index::
   pair: Group; Administration

In-context administration guide
===============================

To help get groups started there is a new system to encourage the group
administrator [#encouragement]_. The current advice includes:

* Start a topic
* Invite people,
* Write some text in the *About* tab, and
* Make a group Private (rather than Secret).

.. index::
   triple: Group; Type; Closed

Closed groups
=============

Administrators can now close groups [#closed]_. There are two reasons for
needing to do this.

#. The group may be *starting*, and the administrator does not want the
   members to post until everyone is in the group.
#. The group may be *finished*, and the administrator does not want any
   more posts to be made, but he or she still wants the archive available.

While there is no front-end user interface that allows the group-type to be
changed [#select]_, an administrator can change the type of the group by
making a change in the ZMI.

.. index::
   pair: Profile; Search

Profile search
==============

A simple profile search has been added [#profileSearch]_. A more complex
search system has not been added because the privacy issues are still being
resolved.

SVG thumbnails
==============

GroupServer now correctly displays a thumbnail of an SVG image at the
bottom of each post [#svg]_. This item was picked from the list of `low
hanging fruit`_, where there are other (relatively) strait forward tasks
listed.

--------------------------------
Changes to the underlying system
--------------------------------

We have made significant changes to the underlying GroupServer system in
the Absinthe release. The system will be easier to maintain because of a
new `configuration system`_, `improved email handling`_, and a `new
authentication system`_. Installation is simpler because relstorage_ is
used by default. There have also been some significant `performance
improvements`_. Developers will notice the `SQLAlchemy update`_, and a
`more flexible group page`_.

The changes to the underlying system have been so extensive that we have
decided to change the naming scheme for the GroupServer releases. The new
releases belong to the **Awesome Aperitifs** series. Hence this *Absinthe
Acquired Arbitrarily* release. Internally, the eggs in this series are
given the version 2.0 (which you can see by looking at the ``versions.cfg``
file in the build directory). The version-number of the *release* will
continue to use the ``month.day`` format. The old series was known as
**Frozen Treats**; *Faloodeh Consumed with an Eye on History* was the
aptly-named last release in that series. (Eggs in the Frozen Treats series
were given the 1.0 version.)

.. index:: Configuration

Configuration system
====================

Administration is now simpler, especially for production systems, as the
configuration for important parts of GroupServer are now in a file that is
external to the ZODB. The new configuration system handles the database,
the `improved email handling`_, and the `new authentication system`_. It is
based on a INI file, located in ``parts/instance/gsconfig.ini``.

.. index::
   pair: Email; SMTP

Improved email handling
=======================

The email-handling subsystem of GroupServer has been completely
rewritten. Changes have been made to both the handling of outgoing mail and
incoming mail.

The setup for the **outgoing** SMTP system has moved from the ZODB
(accessed through the ZMI) to an INI file [#mailhost]_, thanks to the new
`configuration system`_. Documentation for the new outgoing SMTP system can
be found in `the README for the gs.email product`_.

The script that is used to add email messages to a group, the **incoming**
SMTP system, has been rewritten [#smtp2gs]_. It is now easier to use,
better documented, and works. Documentation for the new script can be found
by running ``./bin/smtp2gs -h`` or reading `the README for the
gs.group.messages.add.smtp2gs product`_.

.. index::
   pair: Web-hook; Authentication

New authentication system
=========================

A new authentication system has been created, for the server-side scripts
[#auth]_. These scripts, such as the those involved in the `improved email
handling`_, now pass a *token* to the server when they carry out
tasks. This eliminates the need to store the password of the administrator
in various plain-text files.

.. index:: PostgreSQL, Relstorage

Relstorage
==========

By default `the Relstorage product`_ is now used to store the ZODB. This
system stores the pickled objects in a relational database, rather than in
the file-system. (The PostgreSQL_ database is used by GroupServer.) This
allows greater scalability, without the need to separately install Zope
Enterprise Objects (ZEO).

Performance improvements
========================

There have been some major performance improvements made to GroupServer in
the Absinthe release. This includes the removal of some old poorly
performing code [#divisionObject]_, and altering some of the member
management code [#members]_.

.. index:: Dependencies

``SQLAlchemy`` update
=====================

The entire interface between GroupServer and the PostgreSQL_ relational
database has been rewritten [#dbError]_. This has allowed GroupServer to
update its SQLAlchemy_ dependency from the ancient 0.3 release to the
current 0.7 release.

.. index:: Group

More flexible group page
========================

The group page was refactored to make it more flexible [#groupHome]_. This
allows the addition of the `in-context administration guide`_, and for
other features to be added by skins.

------------
Get Absinthe
------------

To get Absinthe go to `the Downloads page for GroupServer`_ and follow `the
GroupServer Installation documentation`_. Those who already have a
functioning installation can `update an existing GroupServer system`_.

Update an existing GroupServer system
=====================================

Updating a system running the Faloodeh release of GroupServer (12.06) to
Absinthe is a three-step process, which includes updating the relational
database, the products, and the scripts.

*Relational* *Database*

The biggest change that is needed to update GroupServer to the Absinthe
release is to update the rational database, to support the `new search
system`_ and some of the `performance improvements`_. The tables that are
used to store the posts, topics and topic keywords all need to be
updated.

**First**, create a backup.  While every effort has been made to
crate a upgrade path that is smooth and with low risk, there is
still a chance that something can go wrong. As such it is prudent
to **create a backup**. First, **create a backup** of the
relational database::

  $ pg_dump -U gsadmin groupserver > gs-backup.sql

Where ``gsadmin`` is the PostgreSQL user that you set up when installing
GroupServer, and ``groupserver`` is the name of the database.

If you use relstorage_, **create a backup** of the ZODB::

  $ pg_dump -U gszodbadmin groupserverzodb > gs-zodb-backup.sql

Where ``gszodbadmin`` is the PostgreSQL user for ``relstorage`` that you
set up when installing GroupServer, and ``groupserverzodb`` is the name of
the database.

**Posts**

:Note: Update the ``posts`` table **after** you create a backup.

Begin by updating the table that stores the posts.

#.  Log in to the PostgreSQL_ command line::

      $ psql -hlocahlost -Ugsadmin groupserver

    Where ``gsadmin`` is the PostgreSQL user that you set up when
    installing GroupServer, and ``groupserver`` is the name of the
    database.

#.  Alter the ``post`` table to add the full-text retrieval (FTR, or
    full-text search, FTS) column, by executing the following SQL::

     ALTER TABLE post ADD COLUMN fts_vectors tsvector;

#.  Update the rows of the ``post`` table to add the FTR data. This may
    take some time::

     UPDATE post
     SET fts_vectors = to_tsvector('english',
                                   left(coalesce(subject,'') || ' ' || coalesce(body, ''),
                                        1048575));

#.  Create an index for the FTR data. This may take some time::

      CREATE INDEX post_fts_vectors ON post USING gin(fts_vectors);

#.  Create an index for the posts, sorted by the last post date::

      CREATE INDEX post_last_post_date_idx ON post (date DESC);

#.  Create a trigger to update the FTR data whenever a new post is made::

      CREATE TRIGGER fts_vectors_update
        BEFORE INSERT or UPDATE ON post
        FOR EACH ROW EXECUTE PROCEDURE
          tsvector_update_trigger(fts_vectors, 'pg_catalog.english', subject,
                                  body);

**Topics**

Because people search topics as well as posts the FTR information needs to
be present in both tables.

#.  Add the FTR column to the ``topic`` table::

      ALTER TABLE topic ADD COLUMN fts_vectors tsvector;

#.  Drop the old trigger::

      DROP TRIGGER count_word_count_rows ON word_count;

#.  Drop the old tables that were used for searching::

      DROP TABLE topic_word_count;
      DROP TABLE word_count;

    Even with the FTR data duplicated in the ``post`` and ``topic`` table,
    there is a nett saving of space once these two tables are dropped.

#.  Add the function that is used to create the *body* of the topic::

      CREATE OR REPLACE FUNCTION topic_body (topic_id TEXT)
        RETURNS TEXT AS $$
        DECLARE
            topic_text TEXT;
            subject TEXT;
            retval TEXT;
        BEGIN
          SELECT string_agg(post.body, ' ') INTO topic_text
            FROM post
            WHERE post.topic_id = topic_body.topic_id
              AND post.hidden IS NULL;
          SELECT COALESCE(post.subject, '') INTO subject
            FROM post WHERE post.topic_id = topic_body.topic_id LIMIT 1;
          retval := left(subject || ' ' || topic_text, 1048575);
          RETURN retval;
        END;
      $$ LANGUAGE 'plpgsql';

#.  Create the function that will ``topic`` table with FTR data::

      CREATE OR REPLACE FUNCTION topic_ftr_populate ()
        RETURNS void AS $$
          DECLARE
            total_topics REAL;
            trecord RECORD;
            topic_vector tsvector;
            topic_text TEXT;
            i REAL DEFAULT 0;
            p REAL;
          BEGIN
            SELECT CAST(total_rows AS REAL) INTO total_topics
              FROM rowcount WHERE table_name = 'topic';
            FOR trecord IN SELECT * FROM topic WHERE fts_vectors IS NULL LOOP
              RAISE NOTICE 'Topic %', trecord.topic_id;
              topic_vector := to_tsvector('english', topic_body(trecord.topic_id));
              UPDATE topic SET fts_vectors = topic_vector
                WHERE topic.topic_id = trecord.topic_id;
              i := i + 1;
              p := (i / total_topics) * 100;
              RAISE NOTICE '  Progress % %%', p;
            END LOOP;
          END;
      $$ LANGUAGE 'plpgsql';

#.  Populate the ``topic`` table with FTR data. This may take some time::

      SELECT topic_ftr_populate();

#.  Create an index for the FTR data. This may take some time::

      CREATE INDEX topic_fts_vectors ON topic USING gin(fts_vectors);

#.  Create an index for the topics, sorted by the last post date::

      CREATE INDEX topic_last_post_date_idx ON topic (last_post_date DESC);

#.  Create a trigger to update the FTR data::

      CREATE OR REPLACE FUNCTION topic_fts_update ()
        RETURNS TRIGGER AS $$
          DECLARE
            topic_text TEXT;
          BEGIN
            topic_text := topic_body(NEW.topic_id);
            NEW.fts_vectors := to_tsvector('english', topic_text);
            RETURN NEW;
          END;
      $$ LANGUAGE 'plpgsql';
      CREATE TRIGGER topic_update_trigger_01
        BEFORE INSERT OR UPDATE ON topic
        FOR EACH ROW EXECUTE PROCEDURE topic_fts_update ();

**Topic Keywords**

Finally, the system that displays the topic keywords has been changed. The
keywords are now calculated when someone posts, and are stored in the
``topic_keywords`` table. Previously they were calculated when the list of
topics was displayed.

#.  Download the file ``03-keywords.sql``::

      wget --no-check-certificate https://source.iopen.net/groupserver/gs.group.messages.topic/rawfile/tip/gs/group/messages/topic/sql/03-keywords.sql

    This contains the SQL that is normally executed when Absinthe is
    installed.

#.  Interpret (execute) the file in PostgreSQL::

      \i /path/to/the/download/03-keywords.sql

    Where ``/path/to/the/download`` is the full path to where the file
    ``03-keywords.sql`` is stored.

#.  Create the function to populate the new ``topic_keywords`` table::

      CREATE OR REPLACE FUNCTION topic_keywords_populate ()
        RETURNS void AS $$
          DECLARE
            total_topics REAL;
            trecord RECORD;
            topic_text TEXT;
            new_keywords TEXT[];
            i REAL DEFAULT 0;
            p REAL;
          BEGIN
            SELECT CAST(total_rows AS REAL) INTO total_topics
              FROM rowcount WHERE table_name = 'topic';
            FOR trecord IN SELECT * FROM topic LOOP
              RAISE NOTICE 'Topic %', trecord.topic_id;
              topic_text = topic_body(trecord.topic_id);
              SELECT ARRAY(SELECT word
                             FROM topic_keywords(trecord.topic_id, topic_text))
                INTO new_keywords;
              INSERT INTO topic_keywords VALUES(trecord.topic_id, new_keywords);
              i := i + 1;
              p := (i / total_topics) * 100;
              RAISE NOTICE '  Progress % %%', p;
            END LOOP;
          END;
      $$ LANGUAGE 'plpgsql';

#.  Populate the ``topic_keywords`` table. This may take some time::

      SELECT topic_keywords_populate();

**Products**

To update an existing GroupServer installation to Absinthe carry
out the following steps.

#.  Download the Absinthe tar-ball from `the GroupServer download page
    <http://groupserver.org/downloads>`_.

#.  Uncompress the tar-ball::

      $ tar cfz groupserver-12.11.tar.gz

#.  Change to the directory that contains your existing GroupServer
    installation.

#.  Make a backup of your custom configuration::

      $ cp custom.cfg custom-bk.cfg
      $ cp config.cfg config-bk.cfg

#.  Copy the new configuration files to your existing GroupServer
    installation::

      $ cp ../groupserver-12.11/*.cfg .

#.  Restore your custom configuration::

      $ mv custom-bk.cfg custom.cfg
      $ mv config-bk.cfg config.cfg

#.  Disable the creation of the database tables::

      $ echo 1 > var/create-tables.cfg

#.  Disable the creation of a new GroupServer site::

      $ echo 1 > var/setup-gs.cfg

#.  In your existing GroupServer installation run::

      $ ./bin/buildout -n

#.  Restart your GroupServer instance.

**Scripts**

Some external scripts have changed in the Absinthe release of
GroupServer, and need to be changed. In addition some ZMI scripts
should also be updated.

The script ``smtp2zope`` used to be used to marshal an email
message from Postfix into GroupServer. With the `improved email
handling`_ this script should be deleted. The replacement script
is called ``smtp2gs``. It will be created when you update the
products. The command is simpler to use than the old script; the
options for the script are shown by running::

  $ ./bin/smtp2gs --help

Alternatively, `the README for the gs.group.messages.add.smtp2gs product`_
documents the options.

The directory ``potfix_config`` in your GroupServer installation will
contain an example aliases file for Postfix that uses ``smtp2gs``. This can
be used to replace the old calls to GroupServer from Postfix.

**ZMI Scripts**

Two scripts in the ZMI have to be replaced to gain some of the significant
`performance improvements`_.

#.  Visit the ZMI for your site. By default it is at
    <http://localhost:8080/manage>.

#.  Go to the folder ``/example/ListManager``.

#.  Select the ``xwf_email_header`` script.

#.  Replace the contents of the script with the following::

      groupId = list_object.listId()
      siteId = list_object.siteId
      site = getattr(context.Content, siteId)
      group_object = getattr(site.groups, groupId)

      # we copy the propertysheet, because we won't be able to access it
      # in the lower layer
      group_properties = {}
      for p in group_object.propertyItems():
          group_properties[p[0]] = p[1]
      group_properties['id'] = group_object.getId()

      xmailer = getValueFor('xmailer')
      mailto = getValueFor('mailto')
      replyToProp = list_object.getProperty('replyto','')
      if replyToProp == 'sender':
          replyto = None
      else:
          replyto = getValueFor('mailto')

      try:
          group_properties['division_id'] = site.aq_explicit.getId()
          group_properties['division_title'] = site.aq_explicit.title
      except:
          group_properties['division_id'] = ''
          group_properties['division_title'] = ''

      files = []
      try:
          storage = context.FileLibrary2.get_fileStorage()
          for file_id in file_ids:
              file = storage.get_file(file_id)
              if file:
            files.append(file)
      except:
          pass

      return context.email_header(REQUEST, list_object=list_object,
                            group_properties=group_properties,
                            getValueFor=getValueFor, title=title, mail=mail,
                            body=body, files=files, post_id=post_id,
                            mailto=mailto, replyto=replyto,
                            xmailer=xmailer).strip()

#.  Click the ``Save Changes`` button.

#.  Click ``ListManager`` (at the top of the page) to return to the List
    Manager folder.

#.  Select the ``xwf_email_footer`` script.

#.  Replace the contents of the script with the following::

      groupId = list_object.listId()
      siteId = list_object.siteId
      site = getattr(context.Content, siteId)
      group_object = getattr(site.groups, groupId)

      # we copy the propertysheet, because we won't be able to access it
      # in the lower layer
      group_properties = {}
      for p in group_object.propertyItems():
          group_properties[p[0]] = p[1]
      group_properties['id'] = group_object.getId()

      try:
          group_properties['division_id'] = site.aq_explicit.getId()
          group_properties['division_title'] = site.aq_explicit.title
      except:
          group_properties['division_id'] = ''
          group_properties['division_title'] = ''

      # group_properties['canonical_host'] = \
      #   group_object.Scripts.get.option('canonicalHost')
      divConfig = site.DivisionConfiguration
      group_properties['canonical_host'] = divConfig.getProperty('canonicalHost', '')

      try:
          from_addr = context.parseaddr(mail.get('from',''))[1]
      except:
          from_addr = ''

      if from_addr:
          user = context.acl_users.get_userByEmail(from_addr)
      else:
          user = None

      files = []
      try:
          storage = context.FileLibrary2.get_fileStorage()
          for file_id in file_ids:
              file = storage.get_file(file_id)
              if file:
                  files.append(file)
      except:
          pass

      # Get the virtual file folder "files" from the group.

      # Get the public_access_period from "files"
      pap = int(getattr(group_object.files, 'public_access_period', 0))
      # Turn the public_access_period to a Boolean
      pap_set = bool(pap)
      # Pass the Boolean to the "email_footer" template
      mailto = getValueFor('mailto')

      return context.email_footer(REQUEST, list_object=list_object,
                            group_properties=group_properties,
                            getValueFor=getValueFor, title=title,
                            mailto=mailto, mail=mail, body=body,
                            user_object=user, from_addr=from_addr,
                            files=files, post_id=post_id, pap_set=pap_set)

#.  Click the ``Save Changes`` button.

---------
Resources
---------

- Code repository: https://source.iopen.net/groupserver/
- Questions and comments to http://groupserver.org/groups/development
- Report bugs at https://redmine.iopen.net/projects/groupserver

.. [#noSearch] The *Search* box that used to appear on every page has now
               been removed, as it is easier to use the *Search* entry in
               the *Topics* tab. This closes `Bug 3434`_.
.. _Bug 3434: https://redmine.iopen.net/issues/3434
.. [#postSearch] Searching in posts closes `Feature 3497`_.
.. _Feature 3497: https://redmine.iopen.net/issues/3497
.. [#clickableKW] Creating topic keywords that can be clicked closes
                  `Feature 878`_.
.. _Feature 878: https://redmine.iopen.net/issues/878
.. [#FTR] Using the full-text retrieval feature of PostgreSQL_ closes
          `Feature 224`_.
.. _Feature 224: https://redmine.iopen.net/issues/224
.. [#nonAscii] Being able to search for non-ASCII characters closes `Bug
               603`_.
.. _Bug 603: https://redmine.iopen.net/issues/603
.. [#forbidden] Updating the *Permission Denied* page closes `Bug 646`_.
.. _Bug 646: https://redmine.iopen.net/issues/646
.. [#encouragement] Creating the encouragement closes `Feature 3501`_ and
                    `Feature 177`_.
.. _Feature 3501: https://redmine.iopen.net/issues/3501
.. _Feature 177: https://redmine.iopen.net/issues/177
.. [#closed] Creating the closed-group closes `Feature 449`_.
.. _Feature 449: https://redmine.iopen.net/issues/449
.. [#select] The issue for creating a selectable group type is `Feature
             702`_.
.. _Feature 702: https://redmine.iopen.net/issues/702
.. [#profileSearch] The creation of a basic profile search closes `Feature
                    3486`_.
.. _Feature 3486: https://redmine.iopen.net/issues/3486
.. [#svg] Handling SVG Thumbnails closes `Bug 635`_.
.. _Bug 635: https://redmine.iopen.net/issues/635
.. [#mailhost] Moving the SMTP configuration to an INI file means that the
               two ``MailHost`` instances from the ZODB can be removed,
               which closes `Bug 365`_.
.. _Bug 365: https://redmine.iopen.net/issues/365
.. _The README for the gs.email product:
   https://source.iopen.net/groupserver/gs.email/
.. [#smtp2gs] Rewriting the script that is used to add email messages to a
              group closes `Feature 687`_ and `Feature 3536`_.
.. _Feature 687: https://redmine.iopen.net/issues/687
.. _Feature 3536: https://redmine.iopen.net/issues/3536
.. _The README for the gs.group.messages.add.smtp2gs product:
   https://source.iopen.net/groupserver/gs.group.messages.add.smtp2gs/
.. [#auth] The creation of a new authentication system closes `Bug 3416`_.
.. _Bug 3416:  https://redmine.iopen.net/issues/3416
.. _Feature 279: https://redmine.iopen.net/issues/279
.. [#divisionObject] The removal of the old ``division_object`` getter
                     closes `Bug 279`_.
.. _Bug 279: https://redmine.iopen.net/issues/279
.. [#members] The optimisation of the member-handling code closes `Bug
              3659`_.
.. _Bug 3659: https://redmine.iopen.net/issues/3659
.. [#dbError] An unintentional site-effect of rewriting the database
             interface was a fix for `Bug 203`_.
.. _Bug 203: https://redmine.iopen.net/issues/203
.. [#groupHome] As part of the update to the group, `Feature 419`_ was
                closed.
.. _Feature 419: https://redmine.iopen.net/issues/419

..  _GroupServer.org: http://groupserver.org/
..  _OnlineGroups.Net: https://onlinegroups.net/
..  _Creative Commons Attribution-Share Alike 3.0 New Zealand License:
    http://creativecommons.org/licenses/by-sa/3.0/nz/
..  _Michael JasonSmith: http://groupserver.org/p/mpj17
..  _Richard Waid: http://groupserver.org/p/richard
..  _Dan Randow: http://groupserver.org/p/danr
..  _Bill Bushey: http://groupserver.org/p/wbushey
..  _E-Democracy.org: http://forums.e-democracy.org/
..  _Marek Kuziel: https://onlinegroups.net/p/marek
..  _low hanging fruit: https://redmine.iopen.net/projects/groupserver/wiki/LowHangingFruit
..  _The Downloads page for GroupServer: http://groupserver.org/downloads
..  _The GroupServer Installation documentation:
    http://groupserver.org/downloads/install
.. _the Relstorage product: https://pypi.python.org/pypi/RelStorage
.. _PostgreSQL: http://www.postgresql.org
.. _SQLAlchemy: http://www.sqlalchemy.org/
