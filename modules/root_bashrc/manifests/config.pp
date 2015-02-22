##
## Customize root's .bashrc
##
class root_bashrc::config {

    file { '/root/.bashrc':
        source  => 'puppet:///modules/root_bashrc/bashrc_deb',
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
    }

    # Customization for root
    file { '/root/.bashrc_root':
        source  => 'puppet:///modules/root_bashrc/bashrc_root_deb',
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        require => File['/root/.bashrc'],
    }

}
