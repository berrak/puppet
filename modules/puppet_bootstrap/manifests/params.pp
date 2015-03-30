##
## Bootstrap puppet
##
class puppet_bootstrap::params {

    ## Note: The matching IP regex range  in 'puppet_bootstrap::install'
    ## is not managed via this params-file. Thus update these manually.


    ## Local puppet domain

    $home_puppet_server_ip = '192.168.0.222'
    $home_network_domain = 'home.tld'


    ## 1'st public puppet domain

    $public1_puppet_server_ip = '176.10.168.227'
    $public1_network_domain = 'triatagroup.com'

}
