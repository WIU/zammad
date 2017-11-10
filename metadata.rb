name 'zammad'
maintainer 'Matt Mencel'
maintainer_email 'mr-mencel@wiu.edu'
license 'MIT'
description 'Installs/Configures zammad'
long_description 'Installs/Configures Zammad. Zammad is a web-based, open source user support/ticketing solution.'
issues_url 'https://github.com/WIU/zammad/issues' if respond_to?(:issues_url)
source_url 'https://github.com/WIU/zammad' if respond_to?(:source_url)
chef_version '>= 12.5'

version '0.1.3'

supports 'centos', '>= 7.3'

depends 'elasticsearch', '~> 3.4'
depends 'java', '~> 1.0'
depends 'nginx', '~> 7.0'
depends 'postfix'
depends 'sysctl'
depends 'yum-epel'
