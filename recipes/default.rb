#
# Cookbook:: artemis
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'java::default'
version = '2.4.0'
source_url = "https://repository.apache.org/content/repositories/releases/org/apache/activemq/apache-artemis/#{version}"

tar_extract "#{source_url}/apache-artemis-#{version}-bin.tar.gz" do
  target_dir '/usr/local'
  creates "/usr/local/apache-artemis-#{version}"
  user 'root'
  group 'root'
end
