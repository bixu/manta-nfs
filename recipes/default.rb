#
# Cookbook Name:: manta-nfs
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'apt::default'
include_recipe 'build-essential'
include_recipe 'nodejs'

package 'nfs-common'

nodejs_npm 'manta-nfs'

template '/etc/init/mantanfs.conf' do
	source 'mantanfs.conf.erb'
end

template '/etc/manta-nfs.json' do
	source 'mantanfs.json.erb'
end

remote_directory '/root/.ssh/temp-manta-nfs-keys' do
	source 	'temp-manta-nfs-keys'
	files_mode	'0600'
end

service 'mantanfs' do
	provider	Chef::Provider::Service::Upstart
	action	:start
end