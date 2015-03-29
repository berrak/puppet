##
## Manage IDE's
##
class development_editors::install {

    include stdlib

    # HIERA lookup
    $is_markdown = hiera('development_editors::install::markdown')

    if ( str2bool($is_markdown) ) {

        package { [ 'geany', 'geany-plugin-markdown' ] :
            ensure        => installed,
            allow_virtual => true,
        }
    }

}
