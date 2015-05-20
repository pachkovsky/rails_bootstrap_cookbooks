node[:extra_packages].each do |pckg|
  package pckg do
    action :install
  end
end

include_recipe 'nginx::default'
include_recipe 'nodejs::default'

user 'deploy' do
  home '/home/deploy'
  shell '/bin/bash'
  supports manage_home: true
  action :create
end

directory "/home/deploy/.ssh" do
  owner 'deploy'
  group 'deploy'
  action :create
end

template '/home/deploy/.ssh/authorized_keys' do
  owner 'deploy'
  group 'deploy'
end

directory "/var/www/#{node[:application]}" do
  owner 'deploy'
  group 'deploy'
  recursive true
  action :create
end

directory "/var/www/#{node[:application]}/shared" do
  owner 'deploy'
  group 'deploy'
  action :create
end

directory "/var/www/#{node[:application]}/shared/config" do
  owner 'deploy'
  group 'deploy'
  action :create
end

directory '/etc/init/sites' do
  owner 'deploy'
  group 'deploy'
  action :create
end

sudo 'deploy' do
  user      'deploy'
  runas     'root'
  commands  ['/sbin/start', '/sbin/stop', '/sbin/restart']
  nopasswd  true
end

nginx_site node[:application] do
  action :enable
end

nginx_site 'default' do
  action :disable
end