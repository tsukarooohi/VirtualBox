#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#%w{mysql mysql-server}.each do |pkg|
%w{mysql-server}.each do |pkg|
	package pkg do
		action :install
	end
end


service "mysqld" do
	action [:enable, :start]
end

execute "set root password" do
	command "mysqladmin -u root password '#{node['mysql']['server_root_password']}'"
	only_if "mysql -u root -e 'show databases;'"
end


template 'my.cnf' do
	path '/etc/my.cnf'
	source "my.cnf.erb"
	owner 'root'
	group 'root'
	mode '0644'
	notifies :reload, "service[mysqld]"
end
