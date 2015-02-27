# Cookbook Name:: sanoid
# Resource:: syncoid
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

actions :create, :delete
default_action :create

attribute :name, :kind_of => String, :name_attribute => true, :required => true

attribute :dataset, :kind_of => String, :required => true
attribute :user, :kind_of => String, default: node['sanoid']['user']
attribute :server, :kind_of => String, :required => true
attribute :target, :kind_of => String, :required => true
attribute :cron, :kind_of => String, default: '0 0 * * *'

def initialize(*args)
  super
  @action = :create
end