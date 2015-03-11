#
# Manage rsyslog
#
class rsyslog {

    include rsyslog::install, rsyslog::config, rsyslog::service

}