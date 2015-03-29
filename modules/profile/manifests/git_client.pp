##
##  Sample use:
##  profile::git_client { 'bekr': }
##
define profile::git_client {

    ## HIERA lookups
    $gitname  = hiera("profile::git_client::${name}_gitname")
    $gitemail = hiera("profile::git_client::${name}_gitemail")

    include git_client

    file { "/home/${name}/GIT":
        ensure => directory,
        owner  => $name,
        group  => $name,
    }

    file { "/home/${name}/.gitconfig" :
        content => template( 'profile/user_gitconfig.erb' ),
        owner   => $name,
        group   => $name,
        require => Class['git_client'],
    }

    # Add user git bashrc snippet
    file { "/home/${name}/bashrc.d/git.rc" :
        ensure  => present,
        source  => 'puppet:///modules/profile/git.rc',
        owner   => $name,
        group   => $name,
        require => Class['git_client'],
    }

}