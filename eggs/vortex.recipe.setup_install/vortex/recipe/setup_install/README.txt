The ``vortex.recipe.setup_install`` recipe installs a python package using
'setup.py install'.

We have an archive with a demo foo tar ball:

  >>> ls(distros)
  -  foo.tgz

Now let's create a buildout configuration so that we can test the buildout.

  >>> write(sample_buildout, 'buildout.cfg',
  ... """
  ... [buildout]
  ... index = http://download.zope.org/zope3.4
  ... parts = foo
  ...
  ... [foo]
  ... recipe = vortex.recipe.setup_install
  ... url = file://%s/foo.tgz
  ... """ % distros)

Run the buildout

  >>> print system(buildout)
  Getting distribution for 'zc.recipe.cmmi'.
  Got zc.recipe.cmmi 1.1.0.
  Installing foo.
  foo: Downloading
  file:///tmp/tmp...buildoutSetUp/_TEST_/distros/foo.tgz
  foo: Unpacking and configuring
  configuring foo install


If the package is found (by ``import package``) then it is not installed.

  >>> write(sample_buildout, 'buildout.cfg',
  ... """
  ... [buildout]
  ... index = http://download.zope.org/zope3.4
  ... parts = foo
  ...
  ... [foo]
  ... recipe = vortex.recipe.setup_install
  ... url = file://%s/foo.tgz
  ... package = os
  ... """ % distros)

Run the buildout

  >>> print system(buildout)
  Uninstalling foo.
  Installing foo.
  foo: Package os found for ...
