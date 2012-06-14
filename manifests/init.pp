class puppet (
    $server        = hiera("puppet_server"),
    $ca_server     = hiera("puppet_ca_server", hiera("puppet_server")),
    $report_server = hiera("puppet_report_server", hiera("puppet_server")),
    $manage_agent  = false
) {
  include puppet::params
  include concat::setup

  class { 'puppet::agent':
    method        => $cron,
    server        => $server,
    ca_server     => $ca_server,
    report_server => $report_server,
    manage_agent  => $manage_agent,
  }

  concat { $puppet::params::puppet_conf:
    mode => '0644',
    gnu  => $kernel ? {
      'SunOS' => 'false',
      default => 'true',
    }
  }

}

