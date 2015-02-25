##
##  Sample use:
##  git_client::customize { 'bekr': }
##
define git_client::customize {

    ## HIERA lookups
    $gitname  = hiera("git_client::customize::${name}_gitname")
    $gitemail = hiera("git_client::customize::${name}_gitemail")

    include git_client

    file { "/home/${name}/GIT":
        ensure  => directory,
        owner   => $name,
        group   => $name,
    }

    file { "/home/${name}/.gitconfig" :
        content => template( 'git_client/user_gitconfig.erb' ),
        owner   => $name,
        group   => $name,
        require => Class['git_client'],
    }

    # Add user git bashrc snippet
    file { "/home/${name}/bashrc.d/git.rc" :
        ensure  => present,
        source  => 'puppet:///modules/git_client/git.rc',
        owner   => $name,
        group   => $name,
        require => Class['git_client'],
    }

}