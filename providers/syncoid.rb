# Cookbook Name:: sanoid
# Providers:: syncoid
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

#credits to https://github.com/opscode-cookbooks/opscode-backup/ for this provider
action :create do
  cron "syncoid_#{new_resource.name}" do
   minute get_time(new_resource.cron)[:minute]
   hour get_time(new_resource.cron)[:hour]
   day get_time(new_resource.cron)[:day]
   month get_time(new_resource.cron)[:month]
   weekday get_time(new_resource.cron)[:weekday]
   user new_resource.user
   command get_command(new_resource)
   action :create
  end
  Chef::Log.debug "#{new_resource.name} syncoid job created"
  new_resource.updated_by_last_action(true)
end

action :delete do
  cron "syncoid_#{new_resource.name}" do
    minute get_time(new_resource.cron)[:minute]
    hour get_time(new_resource.cron)[:hour]
    day get_time(new_resource.cron)[:day]
    month get_time(new_resource.cron)[:month]
    weekday get_time(new_resource.cron)[:weekday]
    user new_resource.user
    command get_command(new_resource)
    action :delete
  end
  Chef::Log.debug "#{new_resource.name} syncoid job deleted"
  new_resource.updated_by_last_action(true)
end

def get_time(schedule)
  @schedule ||= begin
    s = schedule.split(' ')
    { :minute => s[0], :hour => s[1], :day => s[2], :month => s[3], :weekday => s[4] }
  end
end

def get_command(res)
  cmd = node['sanoid']['syncoid_cmd']
  cmd += " #{res.dataset} "
  cmd += "#{res.user}@"
  cmd += "#{res.server}:"
  cmd += "#{res.target}"

  cmd
end