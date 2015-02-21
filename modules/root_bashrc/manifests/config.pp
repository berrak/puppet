##
## Customize root's .bashrc
##
class root_bashrc::config {
	
	if $::operatingsystem == 'Debian' {
	 
		file { '/root/.bashrc':
			source => 'puppet:///modules/root_bashrc/bashrc_deb',
			 owner => 'root',
			 group => 'root',
			  mode => '0600',
		}
	
		# This file contains all customization for root
		file { '/root/.bashrc_root':
			source => 'puppet:///modules/root_bashrc/bashrc_root_deb',
			 owner => 'root',
			 group => 'root',
			  mode => '0600',
			require => File['/root/.bashrc'],
		}
		
		# If .bash_root changes, source it
		exec { 'deb_source_changes_due_to_changes_in_bashrc_root':
			       path => '/bin:/sbin:/usr/bin:/usr/sbin',
			    command => 'source /root/.bashrc_root',
			  subscribe => File['/root/.bashrc_root'],
			refreshonly => true,
		}	
		
	} else {
		fail("FAIL: Unknown $::operatingsystem distribution. Aborting...")
	}	

}
