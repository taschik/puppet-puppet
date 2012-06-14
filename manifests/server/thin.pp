class puppet::server::thin {

  include puppet::params

  nginx::vhost { "puppetmaster_thin":
    port     => 8140,
    template => "puppet/vhost/nginx/thin.conf.erb",
  }

  concat { "${::puppet::params::puppet_confdir}/config.ru":
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0644',
    before => Thin::App['puppetmaster'],
  }

  concat::fragment { "proctitle":
    order  => '05',
    target => "${::puppet::params::puppet_confdir}/config.ru",
    source => 'puppet:///modules/puppet/config.ru/05-proctitle.rb',
  }

  concat::fragment { "run-puppet-master":
    order  => '99',
    target => "${::puppet::params::puppet_confdir}/config.ru",
    source => 'puppet:///modules/puppet/config.ru/99-run.rb',
  }

  thin::app { 'puppetmaster':
    user    => 'puppet',
    group   => 'puppet',
    servers => 4,
    rackup  => "${::puppet::params::puppet_confdir}/config.ru",
  }

  motd::register {"Puppet master on Thin": }
}
