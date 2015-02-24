##
## Manage virtual users
##
class account {

    @account::virtual { 'jodo' :
        uid         => 1001,
        realname    => 'John Doe',
    }

    @account::virtual { 'bob' :
        uid         => 1002,
        realname    => 'Bob',
    }

}
