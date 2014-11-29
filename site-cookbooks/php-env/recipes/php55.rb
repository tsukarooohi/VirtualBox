#
# Cookbook Name:: php-env
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

yum_repository 'remi' do
	description 'Les RPM de Remi - Repository'
	baseurl 'http://rpms.famillecollet.com/enterprise/6/remi/x86_64/'
	gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
	fastestmirror_enabled true
	action :create
end

yum_repository 'remi-php55' do
	description 'Les RPM de remi de PHP 5.5 pour Enterprise Linux 6'
	baseurl 'http://rpms.famillecollet.com/enterprise/6/php55/$basearch/'
	gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
	fastestmirror_enabled true
	action :create
end

%w{php php-devel php-pdo php-mcrypt php-mbstring php-mysqlnd php-common php-fpm php-opcache}.each do |pkg|
	package pkg do
		action :install
		notifies :restart, "service[php-fpm]"
	end
end

service "php-fpm" do
	action [:enable, :start]
end

%w{/var/lib/php/session}.each do |dir_path|
	directory dir_path do
		owner 'root'
		group 'nginx'
		action :create
	end
end

template 'php.ini' do
	path '/etc/php.ini'
	source "php.ini.erb"
	owner 'root'
	group 'root'
	mode '0644'
	notifies :reload, "service[php-fpm]"
end
template 'www.conf' do
	path '/etc/php-fpm.d/www.conf'
	source "www.conf.erb"
	owner 'root'
	group 'root'
	mode '0644'
	notifies :reload, "service[php-fpm]"
end
