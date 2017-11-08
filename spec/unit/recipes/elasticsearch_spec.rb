require 'spec_helper'

describe 'zammad::elasticsearch' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'centos', version: '7.4.1708') do |node|
      node.normal['zammad']['local_es'] = true
      node.normal['zammad']['local_mta'] = true
    end.converge(described_recipe)
  end

  it 'includes sysctl::apply' do
    expect(chef_run).to include_recipe('sysctl::apply')
  end

  it 'creates the elasticsearch user' do
    expect(chef_run).to create_elasticsearch_user('elasticsearch')
  end

  it 'creates the elasticsearch install' do
    expect(chef_run).to install_elasticsearch_install('elasticsearch')
  end

  it 'creates the elasticsearch configuration' do
    expect(chef_run).to manage_elasticsearch_configure('elasticsearch')
  end

  it 'configures the elasticsearch service' do
    expect(chef_run).to configure_elasticsearch_service('elasticsearch')
  end

  it 'installs mapper-attachments elasticsearch plugin' do
    expect(chef_run).to install_elasticsearch_plugin('mapper-attachments')
    resource = chef_run.elasticsearch_plugin('mapper-attachments')
    expect(resource).to notify('service[elasticsearch]').to(:restart).delayed
  end

  it 'sets up elasticsearch service restart resource' do
    expect(chef_run.service('elasticsearch')).to do_nothing
  end

  it 'runs set_es_url' do
    expect(chef_run).to run_execute('set_es_url')
    resource = chef_run.execute('set_es_url')
    expect(resource).to notify('file[set_es_url]').to(:create).delayed
  end

  it 'sets up set_es_url file resource' do
    expect(chef_run.file('set_es_url')).to do_nothing
  end

  it 'runs rebuild_index' do
    expect(chef_run).to run_execute('rebuild_index')
    resource = chef_run.execute('rebuild_index')
    expect(resource).to notify('file[rebuild_index]').to(:create).delayed
  end

  it 'sets up rebuild_index file resource' do
    expect(chef_run.file('rebuild_index')).to do_nothing
  end
end
