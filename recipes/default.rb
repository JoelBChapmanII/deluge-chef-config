#
# Cookbook:: deluge-chef-config
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_repository 'deluge' do
  uri 'ppa:deluge-team/ppa'
end

package 'deluge package' do
  package_name %w(deluged deluge-webui)
end

user 'deluge' do
  system true
  manage_home true
  home '/home/deluge'
  shell '/bin/false'
end

group 'deluge' do
  members 'deluge'
  system true
end

template 'deluged.service' do
  source 'deluged.service.erb'
  path '/etc/systemd/system/deluged.service'
end

service 'deluged' do
  action [ :enable, :start ]
end

template 'deluge-web.service' do
  source 'deluge-web.service.erb'
  path '/etc/systemd/system/deluge-web.service'
end

service 'deluge-web' do
  action [ :enable, :start ]
end
