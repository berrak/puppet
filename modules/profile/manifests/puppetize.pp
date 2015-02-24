##
## Bootstrap puppet
##
class profile::puppetize {

    include git_client

    ## Is host in private network or in 176-public network
    if $::ipaddress =~ /^192\./ {
        class { puppet_agent::config :
            server_fqdn_for_agent => 'puppet.home.tld',
            server_ip_for_agent   => '192.168.0.222',
        }
    }
    elsif $::ipaddress =~ /^176\./ {
        class { puppet_agent::config :
            server_fqdn_for_agent => 'puppet.triatagroup.com',
            server_ip_for_agent   => '176.10.168.227',
        }
    }
    else {
        fail("FAIL: Host IPv4 (${::ipaddress}) is not on our managed network!")
    }

    ## Install puppet_server configuration
    if $::ipaddress == '192.168.0.222' {
        class { puppet_server::config :
            server_fqdn => 'puppet.home.tld',
            server_ip   => '192.168.0.222',
        }
        include hieradata
    }
    elsif $::ipaddress == '176.10.168.227' {
        class { puppet_server::config :
            server_fqdn => 'puppet.triatagroup.com',
            server_ip   => '176.10.168.227',
        }
        include hieradata
    }

}
