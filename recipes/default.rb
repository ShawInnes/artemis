#
# Cookbook:: artemis
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'java::default'

group 'artemis' do
  action :create
end

user 'artemis' do
  group 'artemis'
  action :create
end

directory "#{node['artemis']['target_path']}/apache-artemis-#{node['artemis']['version']}" do
  user 'artemis'
  group 'artemis'
  action :create
end

tar_extract "#{node['artemis']['source_url']}/apache-artemis-#{node['artemis']['version']}-bin.tar.gz" do
  target_dir node['artemis']['target_path']
  creates "#{node['artemis']['target_path']}/apache-artemis-#{node['artemis']['version']}/bin/artemis"
  user 'artemis'
  group 'artemis'
end

execute 'create broker' do
  cwd node['artemis']['broker_path']
  command "#{node['artemis']['target_path']}/apache-artemis-#{node['artemis']['version']}/bin/artemis create #{node['artemis']['broker_name']} --home #{node['artemis']['target_path']}/apache-artemis-#{node['artemis']['version']} --user #{node['artemis']['broker_username']} --password #{node['artemis']['broker_password']} --role amq --require-login --cluster-user #{node['artemis']['cluster_username']} --cluster-password #{node['artemis']['cluster_password']}"
  creates node['artemis']['broker_home']
  action :run
  notifies :run, 'execute[chown]'
end

execute 'chown' do
  command "chown -R artemis #{node['artemis']['broker_home']}"
  action :nothing
end

template '/etc/systemd/system/artemis.service' do
  source 'artemis.service.erb'
  mode '0644'
  owner 'root'
  group 'root'
end

service 'artemis' do
  action [:enable, :start]
end

template "#{node['artemis']['broker_home']}/etc/bootstrap.xml" do
  source 'bootstrap.xml.erb'
  mode '0644'
  owner 'artemis'
  group 'artemis'
  notifies :restart, 'service[artemis]', :delayed
end

template "#{node['artemis']['broker_home']}/etc/broker.xml" do
  source 'broker.xml.erb'
  mode '0644'
  owner 'artemis'
  group 'artemis'
  notifies :restart, 'service[artemis]', :delayed
end
