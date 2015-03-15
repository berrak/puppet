##
## Manage postfix. Option for mail via ISP smtp relay host.
##
class postfix::install {

    # HIERA lookup
    $has_external_relay_host  = hiera( 'postfix::install::has_external_relay_host' )
    $mail_box_command         = hiera( 'postfix::install::mail_box_command' )

    ## Remove Debian default (conflicting) mail packages
    
    package { 'exim4' :
        ensure => absent,
    }

    package { 'exim4-config' :
        ensure => absent,
    }

    package { 'bsd-mailx' :
        ensure => absent,
    }

    ## Replace with postfix system
    
    package { 'postfix':
        ensure        => installed,
        allow_virtual => true,
        require       => Package['exim4'],
    }

    package { 'heirloom-mailx':
        ensure        => installed,
        allow_virtual => true,
        require       => Package['bsd-mailx'],
    }

    # Install cyrus SASL pluggable authentication modules and common
    # binaries to authenticate with an external smtp service like gmail.
    
    if ( $has_external_relay_host == true ) {

        package { [ 'libsasl2-modules', 'libsasl2-2', 'sasl2-bin' ] :
            ensure        => installed,
            allow_virtual => true,
        }
    }

    # Include wanted (option) local mailserver processing/sorting of mails
    # if ! ( $mail_box_command == '' ) {
    #   include procmail
    # }
    

}
