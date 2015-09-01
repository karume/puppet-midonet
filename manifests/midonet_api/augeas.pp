# == Class: midonet::midonet_api::augeas
#
# Make sure augeas is installed before install tomcat

class midonet::midonet_api::augeas (
  $augeas_packages = $midonet::params::augeas_packages
) inherits midonet::params {

  package { 'augeas-packages':
    ensure => present,
    name   => $augeas_packages,
  }

}

