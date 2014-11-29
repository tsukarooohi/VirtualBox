#
# Cookbook Name:: user
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user 'ssh_user' do
	home "/home/ssh_user"
	supports :manage_home => true
	action [:create]
end
