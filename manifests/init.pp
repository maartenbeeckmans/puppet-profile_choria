#
#
#
class profile_choria (
  Boolean $server,
  Boolean $manage_firewall_entry,
) {
  if $server {
    class { 'choria::broker':
      network_broker => true,
    }
  } else {
    class { 'choria':
      manage_package_repo => true,
    }
  }

  if $manage_firewall_entry {
    firewall { '04223 accept choria':
      dport  => '4223',
      proto  => 'tcp',
      action => 'accept',
    }
  }
}
