# donatecommunity-webhead: Configure the webserver
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

class donatecommunity-webhead(
  $manage_firewall = true,
) {

   # TODO: The donatecommunity conf is currently hardcoded to 127.0.0.1, so the API needs to run with the webhead.
   class {'donatecommunity-api':
   }

   class { "donatecommunity-webhead::nginx":
   }

   # Open the firewall
   if $manage_firewall == true {
      include firewall-config::base

      firewall { '99 allow HTTP traffic':
         state   => ['NEW'],
         dport   => '80',
         proto   => 'tcp',
         action  => accept,
      }
   }
}
