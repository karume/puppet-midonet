# == Class: midonet::midonet_api::augeas
#
# Make sure augeas is installed before install tomcat

class midonet::midonet_api::augeas (
  $augeas_packages = $midonet::params::augeas_packages
) inherits midonet::params {

  package { $augeas_packages:
    ensure => present,
  }

}

