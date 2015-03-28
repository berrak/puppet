##
## Clone of production server as pre-test
##
class role::production_test_server {

    ## 1. Define stage
    stage { 'prereqs':
        before => Stage['main'],
    }

    ## 2. Define boot_strap_puppet
    class boot_strap_puppet {
        include profile::puppetize
    }

    ## 3. Assign class to stage
    class { boot_strap_puppet:
        stage => 'prereqs',
    }

    ## COMMON MODULES
    include boot_strap_puppet
    include root_bashrc
    include apt_config
    include network
    include ntp
    include mount
    include postfix

    ## SECURITY
    include cron_auto_upgrade
    include iptables_fail2ban
    include sudo
    include sysctl

    ## MAINTENANCE
    include rsyslog
    include logrotate
    include ssh_server
    include logwatch

    ## TECHNOLOGY PROFILES
    #include profile::kvm_virtual_machine_host

    ## USER ACCOUNTS
    include account
    Account::Virtual <| title == 'bekr' |>
    git_client::customize { 'bekr': }


}
