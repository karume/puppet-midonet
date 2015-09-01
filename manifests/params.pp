# Class midonet_mem::params
#
# Specify values for parameters and variables for each supported platform
#
class midonet::params {
  case $::osfamily {
    'RedHat': {
      if $::operatingsystem == 'RHEL' {
        case $::operatingsystemrelease {
          '6': {
            $openstack_release      = 'icehouse'
            $midonet_openstack_repo = "http://repo.midonet.org/openstack-${openstack_release}/RHEL"
          }
          '7': {
            $openstack_release      = 'juno'
            $midonet_openstack_repo = "http://repo.midonet.org/openstack-${openstack_release}/RHEL"
          }
          default: {
            fail("$::operatingsystemrelease not supported by ${module_name}")
          }
        }
      }

      # MidoNet API config - Tomcat config for $::osfamily == 'RedHat'
      # ::midonet::midonet_api
      $tomcat_package  = 'tomcat'
      $catalina_base   = '/usr/share/tomcat'
      $augeas_packages = [ 'deltarpm', 'augeas', 'augeas-devel', 'ruby-augeas' ]

      # MidoNet repositories config for $::osfamily == 'RedHat'
      # ::midonet::repository::centos
      $midonet_repo            = 'http://repo.midonet.org/midonet/v2015.06/RHEL'
      $midonet_thirdparty_repo = 'http://repo.midonet.org/misc/RHEL'
      $midonet_stage           = 'stable'
      $midonet_key_url         = 'http://repo.midonet.org/packages.midokura.key'
      $manage_distro_repo      = true
      $manage_epel_repo        = true

      # Cassandra config for $::osfamily == 'RedHat'
      # ::midonet::cassandra
      $conf_dir           = '/etc/cassandra/default.conf'
      $pid_dir            = '/var/run/cassandra'
      $service_path       = '/sbin'

    }

    'Debian': {
      if $::operatingsystem == 'Ubuntu' {
        case $::operatingsystemrelease {
          '12.04': {
            $openstack_release      = 'icehouse'
            $midonet_openstack_repo = "http://repo.midonet.org/openstack-${openstack_release}"
          }
          '14.04': {
            $openstack_release      = 'juno'
            $midonet_openstack_repo = "http://repo.midonet.org/openstack-${openstack_release}"
          }
          default: {
            fail("$::operatingsystemrelease not supported by ${module_name}")
          }
        }
      }

      # MidoNet API config - Tomcat config for $::osfamily == 'Debian'
      # ::midonet::midonet_api
      $tomcat_package  = 'tomcat7'
      $catalina_base = '/var/lib/tomcat7'
      $augeas_packages = 'libaugeas-ruby'

      # MidoNet repositories config for $::osfamily == 'Debian'
      # ::midonet::repository::ubuntu
      $midonet_repo            = 'http://repo.midonet.org/midonet/v2015.06'
      $midonet_thirdparty_repo = 'http://repo.midonet.org/misc'
      $midonet_stage           = 'stable'
      $midonet_key_url         = 'http://repo.midonet.org/packages.midokura.key'
      $midonet_key             = '35FEEF2BAD40EA777D0C5BA6FCE340D250F18FCF'

      # Cassandra config for $::osfamily == 'Debian'
      # ::midonet::cassandra
      $conf_dir           = '/etc/cassandra'
      $pid_dir            = '/var/run/cassandra'
      $service_path       = '/usr/sbin'
  }

    default: {
      fail("Unsupported platform: midonet-${module_name} only supports RedHat and Debian based OS")
    }
  }

    #---------------------------------
    # Default values for global params
    #---------------------------------

    # MidoNet agent config
    # ::midonet::midonet_agent
    $zk_servers = [{
      'ip'   => 'localhost',
      'port' => '2181',
    },]

    # MidoNet ZooKeeper config
    # ::midonet::zookeeper
    $server_id = '1'
    $client_ip = "$::ipaddress"
    $servers = [{
      'id'   => '1',
      'host' => 'localhost',
    },]

    # MidoNet API config
    # ::midonet::midonet_api
    $vtep                 = false
    $keystone_auth        = false
    $keystone_admin_token = undef # Must remain 'undef' if $keystone_auth = false
    $keystone_host        = $::ipaddress
    $keystone_port        = '35357'
    $keystone_tenant_name = 'admin'
    $midonet_api_ip       = $::ipaddress
    $midonet_api_port     = '8080'
    $midonet_api_endpoint = "http://${midonet_api_ip}:${midonet_api_port}/midonet-api"
    $bind_address         = '0.0.0.0'

    # MidoNet cli config
    # ::midonet::midonet_cli
    $username    = 'admin'
    $password    = 'admin'
    $tenant_name = 'admin'

    # Cassandra config
    # ::midonet::cassandra
    $cassandra_seeds    = [ 'localhost', ]
    $seed_address       = 'localhost'
    $storage_port       = '7000'
    $ssl_storage_port   = '7001'
    $client_port        = '9042'
    $client_port_thrift = '9160'

    # MidoNet Neutron plugin config
    # ::midonet::neutron_plugin
    $neutron_keystone_username = 'neutron'
    $neutron_keystone_password = undef
    $neutron_keystone_tenant   = 'services'
    $sync_db                   = false

}


