# donatecommunity-webhead::nginx: This manifest installs the Nginx server and configuration
#
# Copyright 2014 Tom Noonan II (TJNII)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class donatecommunity-webhead::nginx(
) {

   package { 'nginx':
      ensure  => installed,
      require => Yumrepo["epel"],
   }

   # Purge and take over the Nginx config directory, removing stock cruft
   file { "/etc/nginx":
      require => Package["nginx"],
      ensure  => directory,
      purge   => true,
      recurse => true,
      force   => true,
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "puppet:///modules/donatecommunity-webhead/etc.nginx",
  }

  service { 'nginx':
     ensure    => running,
     enable    => true,
     require   => Package["nginx"],
     subscribe => File["/etc/nginx"],
  }
}
