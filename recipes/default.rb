#
# Cookbook Name:: zammad
# Recipe:: default
#

include_recipe 'yum-epel'

yum_repository 'zammad' do
  description 'Repository for zammad/zammad (stable) packages.'
  baseurl 'https://dl.packager.io/srv/rpm/zammad/zammad/stable/el/7/$basearch'
  gpgkey 'https://dl.packager.io/srv/zammad/zammad/key'
  gpgcheck false
  repo_gpgcheck true
  make_cache false
  action :create
end

include_recipe 'java'
include_recipe 'nginx'

package 'zammad'

template '/etc/nginx/conf.d/zammad.conf' do
  mode '0644'
  action :create
end

include_recipe '::elasticsearch' if node['zammad']['local_es']

include_recipe 'postfix' if node['zammad']['local_mta']
