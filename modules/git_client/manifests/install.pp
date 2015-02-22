##
## Manage git
##
class puppet_gitclient::install {

	package { 'git' :
			ensure => present,
	 allow_virtual => true,
	}

}
