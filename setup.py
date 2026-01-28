#!/usr/bin/env python

from distutils.core import setup

import sys
import re

# Leer la versión del archivo __init__.py
with open('__init__.py', 'r', encoding='latin1') as f:
    content = f.read()
    version_match = re.search(r'__version__\s*=\s*["\']([^"\']+)["\']', content)
    __version__ = version_match.group(1) if version_match else "1.0.0"
    
setup(name='pyfiscalprinter',
      version=__version__,
      description='Drivers for fiscal printers (Epson & Hasar) Argentina',
      author='Guillermo Narvaja',
      author_email='guillon@gmail.com',
      maintainer = "Mariano Reingart",
      maintainer_email = "reingart@gmail.com",
      url='http://code.google.com/p/pyfiscalprinter',
      packages=['pyfiscalprinter', ],
      package_dir={'pyfiscalprinter': "."},
      package_data={'pyfiscalprinter': []},
      classifiers = [
            "Development Status :: 5 - Production/Stable",
            "Intended Audience :: Developers",
            "License :: OSI Approved :: GNU Lesser General Public License v3 or later (LGPLv3+)",
            "Natural Language :: Spanish",
            "Programming Language :: Python",
            "Programming Language :: Python :: 3",
            "Programming Language :: Python :: 3.6",
            "Programming Language :: Python :: 3.7",
            "Programming Language :: Python :: 3.8",
            "Programming Language :: Python :: 3.9",
            "Programming Language :: Python :: 3.10",
            "Programming Language :: Python :: 3.11",
            "Programming Language :: Python :: 3.12",
            "Operating System :: OS Independent",
            "Topic :: Office/Business :: Financial :: Point-Of-Sale",
            "Topic :: Software Development :: Libraries :: Python Modules",
            "Topic :: Printing",
      ],
      keywords="fiscal printer hasar epson",
      python_requires='>=3.6',
     )

