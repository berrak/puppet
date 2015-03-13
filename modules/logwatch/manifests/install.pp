##
## Manage logwatch
##
class logwatch::install {

    package { 'logwatch':
        ensure        => installed,
        allow_virtual => true,
    }

}