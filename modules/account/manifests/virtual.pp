##
## Manage virtual users
##
define account::virtual ( $uid, $realname ) {

    ## Use HIERA to get/replace more user data below

    $username = $title

    user { $username:
        ensure      => present,
        uid         => $uid,
        gid         => $username,
        shell       => '/bin/bash',
        home        => "/home/${username}",
        comment     => $realname,
        managehome  => true,
        require     => Group[$username],
    }

    group { $username:
        gid => $uid,
    }

    file { "/home/${username}":
        ensure  => directory,
        owner   => $username,
        group   => $username,
        mode    => 0750,
        require => [ User[$username], Group[$username] ],
    }

    file { "/home/${username}/.ssh":
        ensure  => directory,
        owner   => $username,
        group   => $username,
        mode    => '0700',
        require => File["/home/${username}"],
    }
    
    file { "/home/${username}/bin":
        ensure  => directory,
        owner   => $username,
        group   => $username,
        require => File["/home/${username}"],
    }

    file { "/home/${username}/tmp":
        ensure  => directory,
        owner   => $username,
        group   => $username,
        require => File["/home/${username}"],
    }

    # Local .bashrc sub directory for bashrc snippets 
    file { "/home/${username}/bashrc.d":
        ensure  => directory,
        owner   => $username,
        group   => $username,
        require => File["/home/${username}"],
    }

    # Append one line to original .bashrc to source user customizations.
    file_line { "Enable_${username}_customization" :
        file    => "/home/${username}/.bashrc",
        line    => "[ -f ~/bashrc.d/${username} ] && source ~/bashrc.d/${username}",
        require => File["/home/${username}/bashrc.d"],
    }

    # Default user customization file
    file { "/home/${username}/bashrc.d/${username}":
        source  => "puppet:///modules/account/${username}",
        owner   => "${username}",
        group   => "${username}",
        require => File["/home/${username}/bashrc.d"],
    }

}
