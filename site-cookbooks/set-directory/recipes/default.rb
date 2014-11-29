#
# Cookbook Name:: set-directory
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
directory '/var/www/' do
	owner 'root'
	group 'root'
	mode  '0755'
	action :create
end
directory '/var/www/vhosts/' do
	owner 'root'
	group 'root'
	mode  '0755'
	action :create
end

%w{www admin}.each do |v|
	directory "/var/www/vhosts/#{v}.#{node.directory.domain}/" do
		owner 'root'
		group 'root'
		mode  '0755'
		action :create
	end
	directory "/var/www/vhosts/#{v}.#{node.directory.domain}/httpdocs" do
		owner 'ssh_user'
		group 'ssh_user'
		mode  '0755'
		action :create
	end
	directory "/var/www/vhosts/#{v}.#{node.directory.domain}/logs" do
		owner 'ssh_user'
		group 'ssh_user'
		mode  '0755'
		action :create
	end
	directory "/var/www/vhosts/#{v}.#{node.directory.domain}/httpdocs/webroot" do
		owner 'ssh_user'
		group 'ssh_user'
		mode  '0755'
		action :create
	end
	template 'index.php' do
		path "/var/www/vhosts/#{v}.#{node.directory.domain}/httpdocs/webroot/index.php"
		source "index.php.erb"
		owner 'ssh_user'
		group 'ssh_user'
		mode '0644'
	end
end

