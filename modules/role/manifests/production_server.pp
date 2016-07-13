##
## Production server
##
class role::production_server {

    ## 1. Define stage
    stage { 'prereqs':
        before => Stage['main'],
    }

    ## 2a. Define 'boot_strap_puppet'
    class boot_strap_puppet {
        include puppet_bootstrap
    }
    ## 2b. Define 'realize_user'
    class realize_user {
        include account
        Account::Virtual <| title == 'bekr' |>
    }

    ## 3. Assign classes to stage
    class { 'boot_strap_puppet' :
        stage => 'prereqs',
    }
    class { 'realize_user' :
        stage   => 'prereqs',
        require => Class['boot_strap_puppet'],
    }

    ## COMMON SYSTEM MODULES
    include boot_strap_puppet
    include root_bashrc
    ##include apt_config
    ##include network
    ##include ntp
    ##include mount
    ##include postfix

    ## VIRTUALIZATION SYSTEM MODULES
    ##include kvm

    ## SYSTEM SECURITY
    ##include cron_auto_upgrade
    ##include iptables_fail2ban
    ##include sudo
    ##include sysctl

    ## SYSTEM MAINTENANCE
    ##include rsyslog
    ##include logrotate
    ##include ssh_server
    ##include logwatch

    ## SYSTEM APPLICATIONS (INCL. THEIR REQUIRED TECHNOLOGY)
    

    ## USER ENVIRONMENT PROFILES (ONLY DEFINES)
    profile::git_client { 'bekr': }


}
