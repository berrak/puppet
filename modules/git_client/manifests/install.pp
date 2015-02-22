##
## Manage git
##
class git_client::install {

	package { 'git' :
			ensure => present,
	 allow_virtual => true,
	}

}
