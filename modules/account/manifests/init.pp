##
## Manage virtual users
##
class account {

    @account::virtual { 'jodo' :
        uid         => 1001,
        realname    => 'John Doe',
    }

}
