##
## Host for systemdevelopment
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
    class { 'debs::install' :
        debs_install_list => [ 'firmware-iwlwifi', 'wicd-gtk' ]
    }
    class { 'debs::remove' :
        debs_remove_list => [ 'network-manager' ]
    }

    ## TECHNOLOGY PROFILES
    #include profile::perl_system_development
    #include profile::puppet_system_development

    ## USER ACCOUNTS
    include account
    Account::Virtual <| title == 'bekr' |>
    git_client::customize { 'bekr': }


}
