##
## Host for system development
##
class role::development_host {

    ## 1. Define stage
    stage { 'prereqs':
        before => Stage['main'],
    }

    ## 2. Define boot_strap_puppet
    class boot_strap_puppet {
        include profile::puppetize
    }

    ## 3. Assign class to stage
    class { 'boot_strap_puppet' :
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

    #include wifi
    #class { 'debs::install' :
    #    deb_install_list => [ 'firmware-iwlwifi', 'wicd-cli', 'wpasupplicant' ],
    #}

    ## TECHNOLOGY PROFILES
    #include profile::perl_system_development
    #include profile::puppet_system_development
    #profile::markdown_development { 'bekr': }

    ## USER ACCOUNTS
    include account
    Account::Virtual <| title == 'bekr' |>
    #git_client::customize { 'bekr': }


}
