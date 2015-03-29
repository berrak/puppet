##
## This class manage KVM
##
class kvm::config {

    # Storage pool on it own partition
    file { '/data':
        owner => 'root',
        group => 'root',
    }

    # Subdirectory for vm images
    file { '/data/vm-images':
        ensure  => 'directory',
        owner   => 'root',
        group   => 'root',
        require => File['/data'],
    }

    # Disable libvirt 'default' network, only if 'default' is already started  
    exec { 'Disable_default_network' :
        path    => '/root/bin:/bin:/sbin:/usr/bin:/usr/sbin',
        command => 'virsh net-destroy default',
        onlyif  => 'virsh net-list | grep default',
    }

    # Helper script to create distribution specific kvm base images to clone new guests from
    file { '/root/bin/create-kvm-box.pl':
        content =>  template( 'kvm/create-kvm-box.pl.erb' ),
        owner   => 'root',
        group   => 'root',
        mode    => '0700',
    }

    # Helper perl script to create guests from Debian based images
    file { '/root/bin/create-deb-guest.pl' :
        source => 'puppet:///modules/kvm/create-deb-guest.pl',
        owner  => 'root',
        group  => 'root',
        mode   => '0700',
    }

}
