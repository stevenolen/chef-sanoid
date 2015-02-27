# Cookbook Name:: sanoid
# Attribute:: default
#
# Copyright (C) 2015, Steve Nolen <technolengy@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

default['sanoid']['bin_path'] = '/usr/local/bin'
default['sanoid']['config_path'] = '/etc/sanoid'

case node['platform_family']
  when "debian", "rhel"
   default['sanoid']['user'] = "root"
   default['sanoid']['group'] = "root"
   default['sanoid']['cron_cmd'] = "#{node['sanoid']['bin_path']}/sanoid --cron"
   default['sanoid']['syncoid_cmd'] = "#{node['sanoid']['bin_path']}/syncoid"
  when "freebsd"
   default['sanoid']['user'] = "root"
   default['sanoid']['group'] = "wheel"
   default['sanoid']['cron_cmd'] = "perl -I /usr/local/lib/perl5/site_perl/ -I /usr/local/lib/perl5/site_perl/mach/5.18/ #{node['sanoid']['bin_path']}/sanoid --cron"
   default['sanoid']['syncoid_cmd'] = "perl -I /usr/local/lib/perl5/site_perl/ -I /usr/local/lib/perl5/site_perl/mach/5.18/ #{node['sanoid']['bin_path']}/syncoid"
end
