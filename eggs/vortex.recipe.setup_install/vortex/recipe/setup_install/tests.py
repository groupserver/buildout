import os
import StringIO
import sys
import tarfile
import shutil

import zc.buildout.testing
from zope.testing import doctest

def setUp(test):
    zc.buildout.testing.buildoutSetUp(test)
    zc.buildout.testing.install_develop('vortex.recipe.setup_install', test)
    distros = test.globs['distros'] = test.globs['tmpdir']('distros')
    tarpath = os.path.join(distros, 'foo.tgz')
    tar = tarfile.open(tarpath, 'w:gz')
    setup = setup_template % sys.executable
    info = tarfile.TarInfo('setup.py')
    info.size = len(setup)
    info.mode = 0755
    tar.addfile(info, StringIO.StringIO(setup))

setup_template = """#!%s
import sys
print "configuring foo", ' '.join(sys.argv[1:])
"""

def test_suite():
    return doctest.DocFileSuite(
        'README.txt',
        setUp=setUp,
        tearDown=zc.buildout.testing.buildoutTearDown,
        optionflags=doctest.ELLIPSIS | doctest.NORMALIZE_WHITESPACE,
        )
