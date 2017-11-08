node.default['sysctl']['params']['vm']['max_map_count'] = 262144
include_recipe 'sysctl::apply'

elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch'
elasticsearch_configure 'elasticsearch'
elasticsearch_service 'elasticsearch'

elasticsearch_plugin 'mapper-attachments' do
  action :install
  chef_proxy node['zammad']['use_proxy']
  notifies :restart, 'service[elasticsearch]'
end

service 'elasticsearch' do
  action :nothing
end

execute 'set_es_url' do
  command 'zammad run rails r "Setting.set(\'es_url\', \'http://localhost:9200\')"'
  action :run
  notifies :create, 'file[set_es_url]'
  not_if { File.exist?(Chef::Config[:file_cache_path] + '/set_es_url') }
end

file 'set_es_url' do
  path Chef::Config[:file_cache_path] + '/set_es_url'
  action :nothing
end

execute 'rebuild_index' do
  command 'zammad run rake searchindex:rebuild'
  action :run
  notifies :create, 'file[rebuild_index]'
  not_if { File.exist?(Chef::Config[:file_cache_path] + '/rebuild_index') }
end

file 'rebuild_index' do
  path Chef::Config[:file_cache_path] + '/rebuild_index'
  action :nothing
end
