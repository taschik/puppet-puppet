# IT'S NOT A HACK, IT'S A FEATURE! WHEEEEEEEEEEEE!
class puppet::package::patches {

  # fix facter.
  if $::operatingsystem == 'debian' or $::operatingsystem == 'ubuntu' {
    if $::facterversion == '1.6.6' {
      # Patch facter.
      file{ '/usr/lib/ruby/1.8/facter/virtual.rb':
        source => 'puppet:///modules/puppet/patches/virtual.rb'
      }
    }
    if $::facterversion == '1.6.9' {
      # Patch facter.
      file{ '/usr/lib/ruby/1.8/facter/lsbrelease.rb':
        source => 'puppet:///modules/puppet/patches/lsbrelease.rb'
      }
    }
  }

  if $::operatingsystem == 'ubuntu' {
    if $::puppetversion == '2.7.16' {
      # https://projects.puppetlabs.com/issues/15029
      file{ '/usr/lib/ruby/1.8/puppet/provider/service/upstart.rb':
        source => 'puppet:///modules/puppet/patches/upstart.rb'
      }
    }
  }
}