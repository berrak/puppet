##
## Bootstrap puppet (Note: puppet-server IPs are duplicated in these three params)
##
class profile::puppetize {


    ## puppet_agent and git are always installed on all hosts!
    
    ## looks up where puppet_server hosts IP addresses are in  'puppet_agent::params'
    include puppet_agent
    include git_client
    

    ## Only installed on puppet_server!
    
    ## looks up assigned hosts IP addresses are in 'puppet_server::params'
    include puppet_server
    
    ## looks up where puppet_server hosts IP addresses are in 'hieradata::params'
    include hieradata

}
