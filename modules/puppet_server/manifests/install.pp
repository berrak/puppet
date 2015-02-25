##
## Manage Puppet server
##
class puppet_server::install {

    package { 'puppetmaster':
        ensure        => latest,
        allow_virtual => true,
    }

    package { 'puppet-module-puppetlabs-stdlib':
        ensure        => latest,
        allow_virtual => true,
        require       => Package['puppetmaster'],
    }

}
