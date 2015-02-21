##
## Manage Puppet clients
##
class puppet_agent::service {

	## Jessie systemd defaults for agent is 'running' - disable daemon!
    service { 'puppet_agent':
              name => 'puppet',
            enable => false,
            ensure => stopped,
	       require => Class['puppet_agent::install'],
    }
	
}
