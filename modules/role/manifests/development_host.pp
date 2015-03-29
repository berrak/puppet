##
## Host for system development
##
class role::development_host {

    ## 1. Define stage
    stage { 'prereqs':
        before => Stage['main'],
    }

    ## 2a. Define 'boot_strap_puppet'
    class boot_strap_puppet {
        include profile::puppetize
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

    #include wifi
    #class { 'debs::install' :
    #    deb_install_list => [ 'firmware-iwlwifi', 'wicd-cli', 'wpasupplicant' ],
    #}

    ## USER ENVIRONMENT PROFILES (INCL. REQUIRED TECHNOLOGY)
    #include profile::perl_system_development
    #include profile::puppet_system_development
    #profile::markdown_development { 'bekr': }

    #profile::git_client { 'bekr': }


}
