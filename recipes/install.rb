#
# Cookbook Name:: telegraf-ng
# Recipe:: install
#
# Copyright 2015, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'debian'
  # apt repository configuration
  apt_repository 'influxdb' do
    uri node['telegraf']['apt']['uri']
    components node['telegraf']['apt']['components']
    key node['telegraf']['apt']['key']
    distribution node['telegraf']['apt']['distribution']
    action node['telegraf']['apt']['action']
  end
when 'rhel'
  # yum repository configuration
  yum_repository 'influxdb' do
    description node['telegraf']['yum']['description']
    baseurl node['telegraf']['yum']['baseurl']
    gpgcheck node['telegraf']['yum']['gpgcheck']
    gpgkey node['telegraf']['yum']['gpgkey']
    enabled node['telegraf']['yum']['enabled']
    action node['telegraf']['yum']['action']
  end
end

package 'telegraf' do
  version if node['telegraf']['version']
  notifies :restart, 'service[telegraf]' if node['telegraf']['notify_restart'] && !node['telegraf']['disable_service']
end