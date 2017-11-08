#
# Cookbook Name:: zammad
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'zammad::default' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'centos', version: '7.4.1708') do |node|
      node.normal['zammad']['local_es'] = true
      node.normal['zammad']['local_mta'] = true
    end.converge(described_recipe)
  end

  it 'includes yum-epel' do
    expect(chef_run).to include_recipe('yum-epel')
  end

  it 'creates the zammad yum repository' do
    expect(chef_run).to create_yum_repository('zammad')
  end

  it 'includes java' do
    expect(chef_run).to include_recipe('java')
  end

  it 'includes nginx' do
    expect(chef_run).to include_recipe('nginx')
  end

  it 'includes zammad' do
    expect(chef_run).to install_package('zammad')
  end

  it 'deploys the zammad template for nginx' do
    expect(chef_run).to create_template('/etc/nginx/conf.d/zammad.conf')
  end

  it 'includes zammad::elasticsearch' do
    expect(chef_run).to include_recipe('zammad::elasticsearch')
  end

  it 'includes postfix' do
    expect(chef_run).to include_recipe('postfix')
  end
end
