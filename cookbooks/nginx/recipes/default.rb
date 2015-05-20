package 'nginx' do
  action :install
end

template "/etc/nginx/sites-available/#{node[:application]}" do
  source 'site.conf.erb'
  owner 'root'
  group 'root'
end