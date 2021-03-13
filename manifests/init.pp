#
#
#
class profile_choria (
  Boolean $broker,
  Boolean $manage_firewall_entry,
  Tuple   $site_policies,
  Tuple   $plugin_classes,
  Hash    $server_config,
  Boolean $enable_scout,
) {
  class { 'choria':
    server              => true,
    manage_mcollective  => false,
    manage_package_repo => true,
    server_config       => $server_config,
  }

  class { 'mcollective':
    client         => true,
    site_policies  => $site_policies,
    plugin_classes => $plugin_classes,
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

  if $enable_scout {
    include profile_choria::scout
  }
}
