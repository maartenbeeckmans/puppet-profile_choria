#
#
#
class profile_choria (
  Boolean $client,
  Boolean $manage_firewall_entry,
) {
  if $client {
    class { 'choria':
      manage_package_repo => true,
    }
  } else {
    class { 'choria::broker':
      network_broker => true,
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
