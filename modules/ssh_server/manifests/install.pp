##
## Manage openssh server
##
class ssh_server::install {

    package { 'openssh-server':
        ensure        => installed,
        allow_virtual => true,
    }

}