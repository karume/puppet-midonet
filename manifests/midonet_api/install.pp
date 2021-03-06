# == Class: midonet::midonet_api::install
# Check out the midonet::midonet_api class for a full understanding of
# how to use the midonet_api resource
#
# === Authors
#
# Midonet (http://midonet.org)
#
# === Copyright
#
# Copyright (c) 2015 Midokura SARL, All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
class midonet::midonet_api::install (
  $manage_app_server = $midonet::params::manage_app_server,
  $install_java      = $midonet::params::install_java
) inherits midonet::params {

  require midonet::midonet_api::augeas

  if ($manage_app_server == true) {
    if ($install_java == true) {
      if ! defined(Class['java']) {
        class { 'java':
          distribution => 'jre',
        } ->

        class { 'tomcat':
          install_from_source => false,
        }
      } else {
        class { 'tomcat':
          install_from_source => false,
        }
      }
    }
  }

  package { 'midonet-api':
    ensure  => present,
  }

}

