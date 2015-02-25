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

    ## TECHNOLOGY PROFILES
    #include profile::perl_system_development
    #include profile::puppet_system_development

    ## USER ACCOUNTS
    include account
    Account::Virtual <| title == 'bekr' |>
    git_client::customize { 'bekr': }


}
