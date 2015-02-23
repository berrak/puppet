##
## Manage virtual users
##
class account {

    @account::virtual { 'jodo' :
        uid         => 1001,
        realname    => 'John Doe',
        pass        => generate('/bin/sh', '-c', "mkpasswd -m sha-512 'jodo' | tr -d '\n'"),
    }

}
