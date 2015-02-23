##
## site.pp (Tested: Debian 8.X)
##
node 'dell.home.tld' {
    
    ## Main ROLE of this host
    include role::development_host

}

node 'hp.home.tld' {
    
    ## Main ROLE of this host
    include role::production_test_server

}

