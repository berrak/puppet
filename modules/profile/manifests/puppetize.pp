##
## Bootstrap puppet
##
class profile::puppetize {

    $myhostname = $::hostname

    include git_client

    ##
    ## Install puppet_agent configuration
    ##

    # Is host in private network or in 176-public network
    if $::ipaddress =~ /^192\./ {

        include puppet_agent

        hosts::agent { $myhostname :
            puppet_server_ip => '192.168.0.222',
            network_domain   => 'home.tld',
        }
    }
    elsif $::ipaddress =~ /^176\./ {

        include puppet_agent

        hosts::agent { $myhostname :
            puppet_server_ip => '176.10.168.227',
            network_domain   => 'triatagroup.com',
        }
    }
    else {
        fail("FAIL: Host IPv4 (${::ipaddress}) is not on our managed network!")
    }

    ##
    ## Install puppet_server configuration
    ##
    if $::ipaddress == '192.168.0.222' {
        class { puppet_server::config :
            server_fqdn => 'puppet.home.tld',
            server_ip   => '192.168.0.222',
        }
        include hieradata
        include hosts
    }
    elsif $::ipaddress == '176.10.168.227' {
        class { puppet_server::config :
            server_fqdn => 'puppet.triatagroup.com',
            server_ip   => '176.10.168.227',
        }
        include hieradata
        include hosts
    }

}
