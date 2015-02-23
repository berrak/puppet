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
        stage => prereqs,
    }

    ## COMMON MODULES
    include boot_strap_puppet
    include root_bashrc

    ## TECHNOLOGY PROFILES
    #include profile::kvm_virtual_machine_host

    ## USER ACCOUNTS


}
