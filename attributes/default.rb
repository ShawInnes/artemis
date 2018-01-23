default['java']['jdk_version'] = '8'
default['java']['install_flavor'] = 'openjdk'

# default['java']['install_flavor'] = 'oracle'
# default['java']['oracle']['accept_oracle_download_terms'] = true

default['artemis']['version'] = '2.4.0'
default['artemis']['source_url'] = "https://repository.apache.org/content/repositories/releases/org/apache/activemq/apache-artemis/#{node['artemis']['version']}"
default['artemis']['target_path'] = '/opt'

default['artemis']['broker_name'] = 'artemis'
default['artemis']['broker_username'] = 'artemis'
default['artemis']['broker_password'] = 'artemis'

default['artemis']['broker_path'] = '/var/lib'
default['artemis']['broker_home'] = "#{node['artemis']['broker_path']}/#{node['artemis']['broker_name']}"

default['artemis']['cluster_username'] = 'artemis'
default['artemis']['cluster_password'] = 'artemis'
