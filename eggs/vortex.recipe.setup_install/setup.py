import os
from setuptools import setup, find_packages

def read(*rnames):
    return open(os.path.join(os.path.dirname(__file__), *rnames)).read()

setup(name='vortex.recipe.setup_install',
      version = '1.0dev',
      license='',
      url='http://vortexdna.com/',
      description="zc.buildout recipe for creating files from file templates",
      author='Darryl Cousins',
      author_email='darryl.cousins@treefernwebservices.co.nz',
      long_description=(read('vortex', 'recipe', 'setup_install', 'README.txt')
                        + '\n\n' +
                        read('CHANGES.txt')),
      classifiers = ['Development Status :: 1 - Planning',
                     'Intended Audience :: Developers',
                     'License :: Other/Proprietary License',
                     'Programming Language :: Python',
                     'Operating System :: OS Independent',
                     'Topic :: Software Development :: Build Tools',
                     'Framework :: Buildout',
                     ],

      packages=find_packages(),
      namespace_packages=['vortex', 'vortex.recipe'],
      install_requires=['setuptools',
                        'zc.buildout',
                        'zc.recipe.cmmi',
                        ],
      zip_safe=True,
      entry_points="""
      [zc.buildout]
      default = vortex.recipe.setup_install:SetupInstall
      """
      )
