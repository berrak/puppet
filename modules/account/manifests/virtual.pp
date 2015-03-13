##
## Manage virtual users
##
define account::virtual ( $uid, $realname ) {


    $username = $title

    include stdlib
    include sudo
    #include ssh_server
    include nfs4_client

    ## HIERA lookup
    $has_sudo       = hiera( "account::virtual::${username}_has_sudo" )
    $nfs_consumer   = hiera( "account::virtual::${username}_nfs_consumer" )
    $has_ssh_access = hiera( "account::virtual::${username}_has_ssh_access" )

    user { $username:
        ensure     => present,
        uid        => $uid,
        gid        => $username,
        shell      => '/bin/bash',
        home       => "/home/${username}",
        comment    => $realname,
        managehome => true,
        require    => Group[$username],
    }

    group { $username:
        gid => $uid,
    }

    file { "/home/${username}":
        ensure  => directory,
        owner   => $username,
        group   => $username,
        mode    => '0750',
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
        ensure => present,
        line   => "[ -f ~/bashrc.d/${username} ] && source ~/bashrc.d/${username}",
        path   => "/home/${username}/.bashrc",
    }

    # Default user customization file
    file { "/home/${username}/bashrc.d/${username}":
        source  => "puppet:///modules/account/${username}",
        owner   => $username,
        group   => $username,
        require => File["/home/${username}/bashrc.d"],
    }

    # Add sudo power to this user - if in group 'sudo'
    if ( str2bool($has_sudo) ) {

        exec { "add_${username}_to_sudo_group" :
            command => "usermod -a -G sudo ${username}",
            path    => '/usr/bin:/usr/sbin:/bin',
            unless  => "cat /etc/group | grep sudo | grep ${username}",
            require => Class['sudo'],
        }
    }

#    # Add remote login for unprivileged user - if in group 'sshusers'
#    if ( str2bool($has_ssh_access) ) {
#    
#        exec { "add_${username}_to_sshusers_group" :
#            command => "usermod -a -G sshusers ${username}",
#            path    => '/usr/bin:/usr/sbin:/bin',
#            unless  => "cat /etc/group | grep sshusers | grep ${username}",
#            require => Class['ssh_server'],
#        }
#    }

    # Create local nfs mount directory for this user
    if ( str2bool($nfs_consumer) ) {

        file { "/home/${username}/nfs":
            ensure  => directory,
            owner   => $username,
            group   => $username,
            mode    => '0755',
            require => File["/home/${username}"],
        }
    }

}
