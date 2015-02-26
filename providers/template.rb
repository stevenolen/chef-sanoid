# Cookbook Name:: sanoid
# Providers:: template
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

action :create do
  conf_file = nil
  begin
    conf_file = run_context.resource_collection.find(:template => "#{node['sanoid']['config_path']}/sanoid.conf")
  rescue Chef::Exceptions::ResourceNotFound
    conf_file = template "#{node['sanoid']['config_path']}/sanoid.conf" do
      action :nothing
      mode "644"
      owner "root"
      group "nobody"
      source "sanoid.conf.erb"
      variables({:templates => {}, :datasets => {}})
    end
    new_resource.notifies(:create, conf_file, :delayed)
  end

  #actually build the resources
  Chef::Log.info "TESTTESTSETSETESTSE #{ new_resource }"
  if not conf_file.variables[:templates].has_key?(new_resource.name)
    conf_file.variables[:templates][new_resource.name] = new_resource
    Chef::Log.info "TESTTESTSETSETESTSE #{ conf_file.variables[:templates][2] }"
  end

  new_resource.updated_by_last_action(true)
end