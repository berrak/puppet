##
## Manage virtual users
##
define account::virtual ( $uid, $realname, $pass ) {

    ## Use HIERA to get more user data below

    $username = $title

    user { $username:
        ensure      => present,
        uid         => $uid,
        gid         => $username,
        shell       => '/bin/bash',
        home        => "/home/${username}",
        comment     => $realname,
        password    => $pass,
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

}