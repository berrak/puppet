#
# Manage rsyslog
#
class rsyslog::install {

    package { 'rsyslog':
        ensure        => installed,
        allow_virtual => true,
    }

    # TLS for rsyslog

    package { 'rsyslog-gnutls' :
        ensure        => installed,
        require       => Package['rsyslog'],
        allow_virtual => true,
    }

}