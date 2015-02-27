# Cookbook Name:: sanoid
# Resource:: dataset
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

actions :create

attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :use_template, :kind_of => String, :required => true

attribute :hourly, :kind_of => Integer
attribute :daily, :kind_of => Integer
attribute :monthly, :kind_of => Integer
attribute :yearly, :kind_of => Integer
attribute :autosnap, :kind_of => String
attribute :autoprune, :kind_of => String
attribute :min_percent_free, :kind_of => Integer

#when to run, no need to set these unless you want to be really specific
attribute :hourly_min, :kind_of => Integer
attribute :daily_hour, :kind_of => Integer
attribute :daily_min, :kind_of => Integer
attribute :monthly_mday, :kind_of => Integer
attribute :monthly_mhour, :kind_of => Integer
attribute :monthly_min, :kind_of => Integer
attribute :yearly_mon, :kind_of => Integer
attribute :yearly_mday, :kind_of => Integer
attribute :yearly_hour, :kind_of => Integer
attribute :yearly_min, :kind_of => Integer

#TODO: Monitoring pieces

def initialize(*args)
  super
  @action = :create
end