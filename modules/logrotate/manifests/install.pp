#
# Manage logrotate
#
class logrotate::install {

    package { 'logrotate':
        ensure        => installed,
        allow_virtual => true,
    }

}