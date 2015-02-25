##
## Configure APT
##
class apt_config::config {


    file { '/etc/apt/sources.list':
        source => 'puppet:///modules/apt_config/sources.list',
        owner  => 'root',
        group  => 'root',
    }

    ## Do not install any recommends/suggests by default
    file { '/etc/apt/apt.conf':
        source => 'puppet:///modules/apt_config/apt.conf',
        owner  => 'root',
        group  => 'root',
    }

    # Preference to stable release (always)
    file { '/etc/apt/preferences':
        source => 'puppet:///modules/apt_config/preferences',
        owner => 'root',
        group => 'root',
    }

}
