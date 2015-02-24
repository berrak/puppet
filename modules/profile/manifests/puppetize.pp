##
## Bootstrap puppet
##
class profile::puppetize {

    include profile::params
    $puppet_server_ipaddress_local      = $::puppet_server::params::puppet_server_ipaddress_local
    $puppet_server_ipaddress_public_176 = $::puppet_server::params::puppet_server_ipaddress_public_176

    ## Is host in private network or in 176-public network
    if $::ipaddress =~ /^192\./ {
        $puppet_server_fqdn         = 'puppet.home.tld'
        $puppet_server_ipaddress    = '192.168.0.222'
    }
    elsif $::ipaddress =~ /^176\./ {
        $puppet_server_fqdn         = 'puppet.triatagroup.com'
        $puppet_server_ipaddress    = '176.10.168.227'
    }
    else {
        fail("FAIL: Host IPv4 ($::ipaddress) is not on any managed network!")
    }

    ## Install puppet_server configuration
    if ( $::ipaddress == $puppet_server_ipaddress ) {
        class { puppet_server::config :
            server_fqdn => $puppet_server_fqdn,
            server_ip   => $puppet_server_ipaddress,
        }
        include hieradata
    }

    ## puppet_agent and git are always installed on all hosts!
    class { puppet_agent::config :
        server_fqdn => $puppet_server_fqdn,
        server_ip   => $puppet_server_ipaddress,
    }

    include git_client

}
