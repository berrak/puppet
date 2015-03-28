##
## Manage Puppet clients
##
class puppet_agent::install {

    package { [ 'puppet', 'facter' ] :
        ensure        => present,
        allow_virtual => true,
        before        => Class['puppet::config'],
    }

    file { '/etc/puppet/files' :
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        require => Package['puppet'],
    }

    ## Utilities for root
    file { '/root/bin' :
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0700',
    }

    file { '/root/bin/puppet.exec':
        source  => 'puppet:///modules/puppet_agent/puppet.exec',
        owner   => 'root',
        group   => 'root',
        mode    => '0700',
        require => File['/root/bin'],
    }

    file { '/root/bin/puppet.simulate':
        source  => 'puppet:///modules/puppet_agent/puppet.simulate',
        owner   => 'root',
        group   => 'root',
        mode    => '0700',
        require => File['/root/bin'],
    }

}
