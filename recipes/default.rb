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

#installs sanoid from github master, this seems to be the way!


remote_file "#{node['sanoid']['bin_path']}/sanoid" do
  source "https://raw.githubusercontent.com/jimsalterjrs/sanoid/master/sanoid"
  action :create_if_missing
end

directory "#{node['sanoid']['config_path']}" do
  owner 'root'
  group 'root'
  mode '0750'
  action :create
end

#add syncoid later when we support it.
#remote_file "#{node['sanoid']['bin_path']}/syncoid" do
#  source "https://raw.githubusercontent.com/jimsalterjrs/sanoid/master/syncoid"
#  action :create_if_missing
#end

cron "sanoid" do
  minute '*'
  hour '*'
  day '*'
  month '*'
  weekday '*'
  action :create
  command "#{node['sanoid']['bin_path']}/sanoid --cron"
end