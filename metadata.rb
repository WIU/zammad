name 'zammad'
maintainer 'Matt Mencel'
maintainer_email 'mr-mencel@wiu.edu'
license 'MIT'
description 'Installs/Configures zammad'
long_description 'Installs/Configures zammad'
chef_version '>= 12.5'

version '0.1.0'

supports 'centos'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/zammad/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/zammad' if respond_to?(:source_url)

depends 'elasticsearch', '~> 3.4'
depends 'java', '~> 1.0'
depends 'nginx', '~> 7.0'
depends 'postfix'
depends 'sysctl'
depends 'yum-epel'