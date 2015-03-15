##
## Manage postfix. Option for mail via ISP smtp relay host.
##
class postfix::config {

    include stdlib

    # HIERA lookup
    $mta_type               = hiera( 'postfix::install::mta_type' )
    $has_lan_outbound_mail  = hiera( 'postfix::install::has_lan_outbound_mail' )
    $mynetwork              = hiera( 'postfix::install::network' )
    $smtp_relayhost_ip      = hiera( 'postfix::install::smtp_relayhost_ip' )

    # specific for mailserver
    $server_root_mail_user  = hiera( 'postfix::install::server_root_mail_user' )
    $external_root_gmail_cc = hiera( 'postfix::install::external_root_gmail_cc' )
    $smtp_relayhost_fqdn    = hiera( 'postfix::install::smtp_relayhost_fqdn' )
    $mail_box_command       = hiera( 'postfix::install::mail_box_command' )

    # TODO: use list in yaml to handle multiple internal sub-domains
    $mydomain     = $::domain
    $mysubdomain1 = ''

    $myhostname   = $::hostname
    $myfqdn       = $::fqdn

    # Optional block mail transport for any external destination
    if ( str2bool($has_lan_outbound_mail) == true ) {
        $transport_maps = ''
    } else {
        $transport_maps = 'transport_maps = hash:/etc/postfix/transport'
    }

    if ( $mta_type == 'server' ) {

        file { '/etc/postfix/main.cf' :
            content => template( 'postfix/server.main.cf.erb' ),
            owner   => 'root',
            group   => 'root',
            require => Class['postfix::install'],
            notify  => Class['postfix::service'],
        }

        file { '/etc/postfix/master.cf' :
            content =>  template( 'postfix/server.master.cf.erb' ),
            owner   => 'root',
            group   => 'root',
            require => Class['postfix::install'],
            notify  => Class['postfix::service'],
        }

        # Do not allow mails reach outside local domain
        if ( str2bool($has_lan_outbound_mail) == false ) {

            file { '/etc/postfix/transport' :
                content =>  template( 'postfix/transport.erb' ),
                owner   => 'root',
                group   => 'root',
                require => Class['postfix::install'],
            }
            
            exec { 'refresh_postfix_transport' :
                command     => 'postmap /etc/postfix/transport',
                path        => '/usr/sbin',
                subscribe   => File['/etc/postfix/transport'],
                notify      => Class['postfix::service'],
                refreshonly => true,
            }

        }

        else {

            # Enable and define TLS policy to use with Google smtp
            file { '/etc/postfix/tls_policy' :
                content =>  template( 'postfix/tls_policy.erb' ),
                owner   => 'root',
                group   => 'root',
                require => Class['postfix::install'],
            }

            exec { 'refresh_postfix_tls_policy' :
                command     => 'postmap /etc/postfix/tls_policy',
                path        => '/usr/sbin',
                subscribe   => File['/etc/postfix/tls_policy'],
                notify      => Class['postfix::service'],
                refreshonly => true,
            }

        }


        # If defined, create an alias file and send root mails
        # to an admin user for local and in domain transports.

        if ( ( $server_root_mail_user != '' ) and ( $external_root_gmail_cc != '' ) ) {

            file { '/etc/postfix/virtual' :
                content =>  template( 'postfix/virtualaliases.erb' ),
                owner   => 'root',
                group   => 'root',
                require => Class['postfix::install'],
            }

            exec { 'refresh_postfix_virtual_aliases':
                command     => 'postmap /etc/postfix/virtual',
                path        => '/usr/sbin',
                subscribe   => File['/etc/postfix/virtual'],
                refreshonly => true,
            }
        }

    }

    elsif ( $mta_type == 'satellite' ) {

        file { '/etc/postfix/main.cf' :
            content =>  template( 'postfix/satellite.main.cf.erb' ),
            owner   => 'root',
            group   => 'root',
            require => Class['postfix::install'],
            notify  => Class['postfix::service'],
        }

        # Update the /etc/aliases to enable mail (root) to local
        # lan mail server when using manual 'crontab -e -u root' 

        file { '/etc/aliases' :
            content =>  template( 'postfix/aliases.erb' ),
            owner   => 'root',
            group   => 'root',
            require => Class['postfix::install'],
        }

        exec { 'refresh_postfix_aliases':
            command     => 'newaliases',
            path        => '/usr/bin',
            subscribe   => File['/etc/aliases'],
            notify      => Class['postfix::service'],
            refreshonly => true,
        }

    }
    
    else {
        fail('FAIL: mailhost not specified in yaml file as either satellite or server! Aborting...')
    }

}
