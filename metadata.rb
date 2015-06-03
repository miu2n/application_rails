name             'application_rails'
maintainer       'Nikko Miu'
maintainer_email 'miu2n@nikkomiu.com'
license          'All rights reserved'
description      'Installs/Configures Note House'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'ruby_build'
depends 'yum-epel'
depends 'apt'
depends 'git'
depends 'magic_shell'
