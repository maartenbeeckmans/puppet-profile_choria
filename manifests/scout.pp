#
#
#
class profile_choria::scout (
  Stdlib::Absolutepath $plugindir,
  Array[String]        $monitoring_packages,
) {
  package { $monitoring_packages:
    ensure => installed,
  }
  include profile_choria::scout::common_checks
}
