import logging, os, shutil, tempfile, urllib2, urlparse
import setuptools.archive_util
import zc.buildout
from zc.recipe.cmmi import getFromCache

def system(c):
    if os.system(c):
        raise SystemError("Failed", c)

class SetupInstall:
    """zc.buildout recipe for installing python package.

    Configuration options:

    location
    prefix
    package
    executable

    """

    def __init__(self, buildout, name, options):
        self.name, self.options = name, options
        directory = buildout['buildout']['directory']
        self.download_cache = buildout['buildout'].get('download-cache')
        self.install_from_cache = buildout['buildout'].get('install-from-cache')

        if self.download_cache:
            self.download_cache = os.path.join(
                directory, self.download_cache, 'cmmi')

        location = options.get(
            'location', buildout['buildout']['parts-directory'])
        options['location'] = os.path.join(location, name)
        options['prefix'] = options['location']
        python = options.get('python', buildout['buildout']['python'])
        options['executable'] = buildout[python]['executable']

    def install(self):
        logger = logging.getLogger(self.name)
        url = self.options['url']

        retval = 1
        package = self.options.get('package', '')
        if package != '':
            retval = os.WEXITSTATUS(os.system("%s -c 'import %s'" %
                                    (self.options['executable'],
                                    self.options['package'])))
        if retval == 0:
            logger.info('Package %s found for %s' % 
                                (self.options['package'],
                                self.options['executable']))
            return ()


        fname = getFromCache(
            url, self.name, self.download_cache, self.install_from_cache)
 
        # now unpack and work as normal
        tmp = tempfile.mkdtemp('buildout-'+self.name)
        logger.info('Unpacking and configuring')
        setuptools.archive_util.unpack_archive(fname, tmp)
        here = os.getcwd()
        entries = []

        os.chdir(tmp)
        if not os.path.exists('setup.py'):
            entries = os.listdir(tmp)
            os.chdir(entries[0])
            if not os.path.exists('setup.py'):
                logger.info("Couldn't find setup.py")
                os.chdir(here)
                return ()
        system("%s setup.py install" % (self.options['executable']))
        os.chdir(here)

        # cleanup
        shutil.rmtree(tmp)
        shutil.rmtree(os.path.dirname(fname))
        return ()

    update = install

