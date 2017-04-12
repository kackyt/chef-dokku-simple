#
# Cookbook Name:: dokku-simple
# Recipe:: default
#
# Copyright 2014, Ric Lister
#
# All rights reserved - Do Not Redistribute
#

include_recipe "dokku-simple::install"
include_recipe "dokku-simple::ssh_users"
include_recipe "dokku-simple::vhost"
include_recipe "dokku-simple::app_envs"

## initial git push works better if we restart docker first
service 'docker' do
  if node['platform_version'].to_f >= 15
    provider Chef::Provider::Service::Systemd
  else
    provider Chef::Provider::Service::Upstart
  end
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
