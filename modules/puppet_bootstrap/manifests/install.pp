##
## Bootstrap puppet
##
class puppet_bootstrap::install {

    $myhostname = $::hostname

    include puppet_bootstrap::params
    include git_client

    ##
    ## Install puppet_agent configuration
    ##

    # Is host in private network or in 176-public network
    if $::ipaddress =~ /^192\./ {

        include puppet_agent

        hosts::agent { $myhostname :
            puppet_server_ip => $::puppet_bootstrap::params::home_puppet_server_ip,
            network_domain   => $::puppet_bootstrap::params::home_network_domain,
        }
    }
    elsif $::ipaddress =~ /^176\./ {

        include puppet_agent

        hosts::agent { $myhostname :
            puppet_server_ip => $::public1_bootstrap::params::public1_puppet_server_ip,
            network_domain   => $::public1_bootstrap::params::public1_network_domain,
        }
    }
    else {
        fail("FAIL: Host IPv4 (${::ipaddress}) is not on our managed network!")
    }

    ##
    ## Install puppet_server configuration
    ##
    if $::ipaddress == $::puppet_bootstrap::params::home_puppet_server_ip {
        class { puppet_server::config :
            server_fqdn => "puppet.$::puppet_bootstrap::params::home_network_domain",
            server_ip   => $::puppet_bootstrap::params::home_puppet_server_ip,
        }
        include hieradata
        include hosts
    }
    elsif $::ipaddress == $::public1_bootstrap::params::public1_puppet_server_ip {
        class { puppet_server::config :
            server_fqdn => "puppet.$::public1_bootstrap::params::public1_network_domain",
            server_ip   => $::public1_bootstrap::params::public1_puppet_server_ip,
        }
        include hieradata
        include hosts
    }

}
