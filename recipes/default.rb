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
  make_cache false # https://github.com/zammad/zammad/issues/1632
  action :create
end

include_recipe 'java'
include_recipe 'nginx'

yum_package 'zammad' do
  action :upgrade
  version node['zammad']['version']
end

template '/etc/nginx/conf.d/zammad.conf' do
  mode '0644'
  action :create
end

include_recipe '::elasticsearch' if node['zammad']['local_es']

include_recipe 'postfix' if node['zammad']['local_mta']

## MONKEYPATCH: Have to delete the zammad repo at the end of the run or chef-client fails on next run
# https://github.com/zammad/zammad/issues/1632
file '/etc/yum.repos.d/zammad.repo' do
  action :delete
end
