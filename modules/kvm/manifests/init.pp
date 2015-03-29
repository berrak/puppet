##
## This class manage KVM
##
class kvm {

    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (kvm) is only for Debian based distributions! Aborting...')
    }

    include kvm::install, kvm::config

}
