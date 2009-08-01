# -*- coding: utf-8 -*-
"""Recipe setupgs. Many thanks to the collective.recipe.updateplone authors :) """

import os
import tempfile
import sys

def quote_command(command):
    # Quote the program name, so it works even if it contains spaces
    command = " ".join(['"%s"' % x for x in command])
    if sys.platform[:3].lower() == 'win': 
        # odd, but true: the windows cmd processor can't handle more than 
        # one quoted item per string unless you add quotes around the 
        # whole line. 
        command = '"%s"' % command 
    return command

class Recipe(object):
    """zc.buildout recipe"""

    def __init__(self, buildout, name, options):
        self.buildout, self.name, self.options = buildout, name, options

        # suppress script generation
        self.options['scripts'] = ''
        options['bin-directory'] = buildout['buildout']['bin-directory']

    def install(self):
        """Installer"""
        runonce = 'run-once' in self.options and \
                   self.options['run-once'].lower() or 'true'
        #We'll use the existance of this file as flag for the run-once option
        file_name = os.path.join(self.buildout['buildout']['directory'],
                                 'var', "%s.cfg" % self.name)

        if runonce not in ['false', 'off', 'no']:
            if os.path.exists(file_name):
                print "\n************************************************"
                print "Skipped: [%s] has already been run" % self.name
                print "If you want to run it again set the run-once option"
                print "to false or delete %s" % file_name
                print "************************************************\n"
                return
            else:
                file(file_name, 'w').write('1')
        
        instance_ctl = os.path.join(self.buildout['buildout']['bin-directory'],
                                    'instance')
        
        recipe_egg_path = os.path.dirname(__file__)[:-len(self.options['recipe'])].replace("\\","/")
        template_file = os.path.join(os.path.dirname(__file__), 'script.py_tmpl').replace("\\","/")
        template = open(template_file, 'r').read()

        zope_admin_name = self.options['zope_admin_name']
        instance_id = self.options['instance_id']
        instance_title = self.options['instance_title']
        gs_admin_name = self.options['gs_admin_name']
        gs_admin_password = self.options['gs_admin_password']
        gs_support_email = self.options['gs_support_email']
        gs_timezone = self.options['gs_timezone']
        gs_hostname = self.options['gs_hostname']
        gs_verification_email = self.options['gs_verification_email']
        gs_registration_email = self.options['gs_registration_email']
        database_host = self.options['database_host']
        database_port = self.options['database_port']
        database_admin = self.options['database_admin']
        database_username = self.options['database_username']
        database_password = self.options['database_password']
        database_name = self.options['database_name']
        sql_base = self.options['sql_base']
        
        template = template % locals()
        
        tmp_file = tempfile.mktemp().replace("\\","/")
        file(tmp_file, 'w').write(template)
                
        os.system(quote_command([instance_ctl, "run", tmp_file]))
        
        return tuple()

    def update(self):
        """Updater"""
        self.install()
