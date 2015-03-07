##
## Manage Puppet clients
##
class puppet_agent::service {

    ## Jessie systemd defaults for agent is 'running' - disable daemon!
    service { 'puppet_agent':
        ensure  => stopped,
        name    => 'puppet',
        enable  => false,
        require => Class['puppet_agent::install'],
    }

}
