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
    class { boot_strap_puppet:
        stage => prereqs,
    }

    ## Generic includes
    include boot_strap_puppet
    include root_bashrc
    
    ## Specific PROFILES for this host
    #include profile::perl

}
