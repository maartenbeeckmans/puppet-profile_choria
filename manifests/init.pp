#
#
#
class profile_choria (
  Boolean $broker,
  Boolean $manage_firewall_entry,
) {
  class { 'choria':
    manage_package_repo => true,
  }

  if $broker {
    class { 'choria::broker':
      network_broker => true,
    }
    if $manage_firewall_entry {
      firewall { '04223 accept choria peers':
        dport  => '4223',
        proto  => 'tcp',
        action => 'accept',
      }
    }
  }

  if $manage_firewall_entry {
    firewall { '04222 accept choria':
      dport  => '4222',
      proto  => 'tcp',
      action => 'accept',
    }
  }
}
