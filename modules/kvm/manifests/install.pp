##
## This class manage KVM
##
class kvm::install {

    package { [ 'qemu-kvm', 'libvirt-bin', 'virtinst', 'libguestfs-tools', 'libxml-twig-perl' ] :
        ensure        => present,
        allow_virtual => true,
    }

}
