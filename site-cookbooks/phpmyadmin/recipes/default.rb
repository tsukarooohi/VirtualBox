# yum_repository 'remi' do
# 	description 'Les RPM de Remi - Repository'
# 	baseurl 'http://rpms.famillecollet.com/enterprise/6/remi/x86_64/'
# 	gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
# 	fastestmirror_enabled true
# 	action :create
# end

# yum_repository 'remi-php55' do
# 	description 'Les RPM de remi de PHP 5.5 pour Enterprise Linux 6'
# 	baseurl 'http://rpms.famillecollet.com/enterprise/6/php55/$basearch/'
# 	gpgkey 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi'
# 	fastestmirror_enabled true
# 	action :create
# end

%w{phpMyAdmin}.each do |pkg|
	package pkg do
		action :install
	end
end

template 'config.inc.php' do
	path '/usr/share/phpMyAdmin/config.inc.php'
	source "config.inc.php.erb"
	owner 'root'
	group 'root'
	mode '0644'
end

template 'phpmyadmin.conf' do
	path '/etc/nginx/conf.d/phpmyadmin.conf'
	source "phpmyadmin.conf.erb"
	owner 'root'
	group 'root'
	mode '0644'
	notifies :reload, "service[nginx]"
end


