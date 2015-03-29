#
# This defines a Debian Jessie new KVM-based VM-guest 
#
# Usage: kvm::add_guest { 'trise' :
#                    local_guest_gw => '192.168.0.1',
#                   local_guest_ip  => '192.168.0.41',
#                 local_mac_address => '52:54:00:00:00:41', 
#                  local_guest_bcst => '192.168.0.255',
#                  local_guest_netw => '192.168.0.0',
#                   local_hostname  => 'trise',
#                       bridge_name => 'kvmbr0',
#                        auto_start => 'true',
#                           os_name => 'debian' | 'oracle6',
#               local_guest_netmask => '255.255.255.0',
#                local_guest_domain => 'home.tld',
#    }
#
define kvm::add_guest ( $local_guest_gw, $local_guest_ip, $local_mac_address, $local_guest_bcst, $local_guest_netw, $local_hostname, $bridge_name, $auto_start, $os_name, $local_guest_netmask, $local_guest_domain ) {


    if ! ( $::operatingsystem == 'Debian' ) {
        fail('FAIL: This module (kvm::add_guest) is only for Debian based distributions! Aborting...')
    }

    include kvm

    # Domain name used by virsh/libvirt
    $guest_name = $name 

    # Debian guest configuration
    file { "/etc/libvirt/qemu/${guest_name}.xml":
        content =>  template( "kvm/${guest_name}.xml.erb" ),
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        require => File['/root/bin/create-deb-guest.pl'],
    }

    ## UPDATE WITH JESSIE IMAGE!

    # Create the new guest (from '/data/vm-images/wheezy.img', which must exist!) 
    exec { "Create_new_guest_${guest_name}" :
        path    => '/root/bin:/bin:/sbin:/usr/bin:/usr/sbin',
        command => "/root/bin/create-deb-guest.pl $guest_name $local_guest_gw $local_guest_ip $local_mac_address $local_guest_bcst $local_guest_netw $local_hostname $bridge_name $local_guest_netmask $local_guest_domain",
        timeout => 0, 
        unless  => "ls /data/vm-images/ | grep $guest_name",
        require => File["/etc/libvirt/qemu/${guest_name}.xml"],
    }

    if ( $auto_start == 'true') {

        # Create link (i.e. enables virsh 'autostart')
        file { "/etc/libvirt/qemu/autostart/${guest_name}.xml":
            ensure  => present,
            target  => "/etc/libvirt/qemu/${guest_name}.xml",
            require => File["/etc/libvirt/qemu/${guest_name}.xml"],
        }

    }

}
