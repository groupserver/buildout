import sys
import transaction

from Testing import makerequest
from Acquisition import aq_base
from AccessControl.SecurityManagement import newSecurityManager
from Products.GroupServer.groupserver import manage_addGroupserverSite
import commands

SQL_SETUP_FILES = ('%s/src/XWFMailingListManager/sql/email.sql',
                   '%s/src/XWFChat/sql/chat.sql',
                   '%s/src/GSAuditTrail/sql/audit_trail.sql',
                   '%s/src/GSGroupMember/sql/user_invitation.sql',
                   '%s/src/GSGroupMember/sql/user_group_member.sql',
                   '%s/src/GSSearch/sql/update_word_count.sql',
                   # create user related tables
                   '%s/src/CustomUserFolder/sql/user.sql',
                   '%s/src/CustomUserFolder/sql/verify.sql',
                   '%s/src/CustomUserFolder/sql/user_nickname.sql',
                   '%s/src/CustomUserFolder/sql/user_invitation.sql',
                   '%s/src/CustomUserFolder/sql/password_reset.sql')

def execute_createuser(admin, user, host, port):
    commands.getoutput('createuser -d -r -l -S -U %s -h %s -p %s %s' %
                                                (admin, host, port, user))
    
def execute_createdb(user, host, port, database):
    commands.getoutput('createdb -E UTF8 -U %s -h %s -p %s %s' % 
                                                (user, host, port, database))
    commands.getoutput('createlang -U %s -h %s -p %s plpgsql %s' %
                                                (user, host, port, database))

def execute_psql_with_file(user, host, port, database, filename):
    status, output = commands.getstatusoutput('psql -U %s -h %s -p %s -d %s -f %s' % (user,
                                                                              host,
                                                                              port,
                                                                              database,
                                                                              filename))
    return (status, output)

class SetupGS(object):
    """ Setup GS.
    
    """
    def __init__(self,
                 app,
                 zope_admin_name=''):
        admin = app.acl_users.acl_users.getUserById(zope_admin_name)
        admin = admin.__of__(app.acl_users)
        newSecurityManager(None, admin)
        self.app = makerequest.makerequest(app)
    
    
    def create_database_user(self, admin,user, host, port):
        execute_createuser(admin, user, host, port)
        
    def create_database(self, user, host, port, database):
        execute_createdb(user, host, port, database)
        
    def setup_database(self, user, host, port, sql_base, database):
        for fname in SQL_SETUP_FILES:
            s,o = execute_psql_with_file(user, host, port, database, fname % sql_base)
            if o:
                print o
       
    def create_site(self,
                    id, title, initial_user, initial_password,
                    support_email, timezone,
                    canonicalHost, userVerificationEmail, registrationEmail,
                    databaseHost, databasePort,
                    databaseUsername, databasePassword,
                    databaseName): 
        manage_addGroupserverSite(self.app,
                                  id, title, initial_user, initial_password,
                                  support_email, timezone,
                                  canonicalHost, userVerificationEmail, registrationEmail,
                                  databaseHost, databasePort,
                                  databaseUsername, databasePassword,
                                  databaseName)