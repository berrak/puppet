##
## System git configuration
##
class git_client::config {

    $mygiteditor = '/bin/nano'
    $mylogformat = '%Cred%h%Creset -%C(Yellow)%d%Creset%s%Cgreen(%cr) %C(bold blue)<%an>%Creset'

    file { '/etc/gitconfig' :
        content => template( 'git_client/system_gitconfig.erb' ),
        require => Class['git_client::install'],
    }
}
