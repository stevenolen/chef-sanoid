# Cookbook Name:: sanoid
# Receipe:: default
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

#Grab pre-requisities
case node['platform_family']
when 'freebsd'
  package 'p5-Config-IniFiles'
  package 'p5-libwww'
else
 include_recipe "perl"
 cpan_module "Config::IniFiles"
 cpan_module "LWP::Simple"
end

#installs sanoid/syncoid from github master, this seems to be the way!
remote_file "#{node['sanoid']['bin_path']}/sanoid" do
  source "https://raw.githubusercontent.com/jimsalterjrs/sanoid/master/sanoid"
  user node['sanoid']['user']
  group node['sanoid']['group']
  mode '0750'
  action :create_if_missing
end

remote_file "#{node['sanoid']['bin_path']}/syncoid" do
  source "https://raw.githubusercontent.com/jimsalterjrs/sanoid/master/syncoid"
  user node['sanoid']['user']
  group node['sanoid']['group']
  action :create_if_missing
end

directory node['sanoid']['config_path'] do
  user node['sanoid']['user']
  group node['sanoid']['group']
  mode '0750'
  action :create
end

cron "sanoid" do
  minute '*'
  hour '*'
  day '*'
  month '*'
  weekday '*'
  action :create
  command node['sanoid']['cron_cmd']
end

template "#{node['sanoid']['config_path']}/sanoid.conf" do
  action :nothing
  source 'sanoid.conf.erb'
  user node['sanoid']['user']
  group node['sanoid']['group']
  mode 0644
  variables(sanoid: Array.new)
end

accumulator 'sanoid.conf.templates' do
  target template: "#{node['sanoid']['config_path']}/sanoid.conf"
  filter { |resource| resource.is_a? Chef::Resource::SanoidTemplate or resource.is_a? Chef::Resource::SanoidDataset}
  transform do |resources|
    list = resources.map { |r| r }
    list.compact.sort_by { |r| r.name }
  end
  variable_name :sanoid
end