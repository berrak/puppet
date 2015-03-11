##
## Manage default NTP client and set up local NTP client/server
##
class ntp::config {

    ## HIERA lookups
    $local_ntp_server_ipaddr = hiera( 'ntp::config::local_ntp_server_ipaddr')
    $local_ntp_srvnet = hiera( 'ntp::config::local_ntp_srvnet' )
    $local_ntp_srvmask = hiera( 'ntp::config::local_ntp_srvmask' )

    $local_ntp_server_ipaddr = hiera( 'ntp::config::public_ntp_servers')

    ## Internal NTP client och lan server configuration
    if ! ( $local_ntp_server_ipaddr == '' ) {

        # Local NTP server configuration
        if ( $::ipaddress == $local_ntp_server_ipaddr ) {

            file { '/etc/ntp.conf':
                content =>  template( 'ntp/ntp.conf.lanserver.erb' ),
                owner   => 'root',
                group   => 'root',
                require => Class['ntp::install'],
                notify  => Class['ntp::service'],
            }

        # Local NTP client configuration
        } else {

            file { '/etc/ntp.conf':
                content =>  template( 'ntp/ntp.conf.lanclient.erb' ),
                owner   => 'root',
                group   => 'root',
                require => Class['ntp::install'],
                notify  => Class['ntp::service'],
            }

        }

        # Status test script
        file { '/root/bin/ntp.time' :
            content =>  template( 'ntp/ntp.time.erb' ),
            mode    => '0700',
            owner   => 'root',
            group   => 'root',
            require => Package['ntp'],
        }
        
    ## Use external NTP servers for client configuration        
    } else {

        file { '/etc/ntp.conf':
            content =>  template( 'ntp/ntp.conf.erb' ),
            owner   => 'root',
            group   => 'root',
            require => Class['ntp::install'],
            notify  => Class['ntp::service'],
        }

    }

}
