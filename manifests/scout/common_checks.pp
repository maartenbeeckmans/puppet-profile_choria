#
#
#
class profile_choria::scout::common_checks (
  Stdlib::Absolutepath $plugindir = $::profile_choria::scout::plugindir,
) {
  Choria::Scout_check {
    annotations => {
      environment => $::environment,
    }
  }

  choria::scout_check { 'heartbeat':
    builtin        => 'heartbeat',
    check_interval => '1m',
  }

  choria::scout_check { 'goss':
    builtin => 'goss'
  }


  if $facts['os']['family'] == 'Debian' {
    choria::scout_check { 'check_apt':
      plugin => "${plugindir}/check_apt",
    }
  }

  #$facts['partitions'].each |$partition| {
  #  choria::scout_check { "check_disk ${partition[0][mount]}":
  #    plugin      => "${plugindir}/check_disk",
  #    arguments   => "-w 10% -c 5% -p ${partition[0][mount]}",
  #    annotations => {
  #      environment => $::environment,
  #    }
  #  }
  #}

  choria::scout_check{ 'check_dns':
    plugin    => "${plugindir}/check_dns",
    arguments => "-H ${facts['networking']['fqdn']}",
  }

  choria::scout_check{ 'check_load':
    plugin    => "${plugindir}/check_load",
    arguments => '-w 15,10,5 -c 30,25,20',
  }

  choria::scout_check{ 'check_mailq':
    plugin    => "${plugindir}/check_mailq",
    arguments => '-M postfix -w 5 -c 10',
  }

  choria::scout_check{ 'check_ntp_time':
    plugin    => "${plugindir}/check_ntp_time",
    arguments => '-H time1.google.com',
  }

  choria::scout_check{ 'check_users':
    plugin    => "${plugindir}/check_users",
    arguments => '-w 5 -c 10',
  }

  choria::scout_check{ 'check_swap':
    plugin    => "${plugindir}/check_users",
    arguments => '-w 50% -c 25%',
  }

  # oom killer
  # cronjobs
  # systemd
  # puppet
  # ssh

}
