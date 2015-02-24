##
## Manage virtual users
##
class account {

    # Use command: '$mkpasswd -m sha-512' to generate a user passwd.
    # Then paste resulting hash with quotes, as below.
    # Cannot use puppet function:
    # generate('/bin/sh', '-c', "mkpasswd -m sha-512 $passwd | tr -d '\n'")
    # since it will run every puppet run...

    @account::virtual { 'jodo' :
        uid         => 1001,
        realname    => 'John Doe',
        pass        => '$6$cGKNkkFinn9RW$GA7HkYhzO54WOqDSDDLSxJ2Cq1vF/QJmrdMpWRuka88YADuklVdLtKOhxV/ov9uzPUHdmJw8a91N5K0KKZHlc/'
    }

}
