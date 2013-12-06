#
# == Class: sshd::params
#
# Defines some variables based on the operating system
#
class sshd::params {

    case $::osfamily {
        'RedHat': {
            $package_name = 'openssh-server'
            $service_name = 'sshd'

            if $::operatingsystem == 'Fedora' {
                $service_start = "/usr/bin/systemctl start ${service_name}.service"
                $service_stop = "/usr/bin/systemctl stop ${service_name}.service"
            } else {
                $service_start = "/sbin/service $service_name start"
                $service_stop = "/sbin/service $service_name stop"
            }
        }
        'Debian': {
            $package_name = 'openssh-server'
            $service_name = 'ssh'
            $service_start = "/usr/sbin/service $service_name start"
            $service_stop = "/usr/sbin/service $service_name stop"
        }
        'FreeBSD': {
            $service_name = 'sshd'
            $service_command = "/usr/sbin/service $service_name"
            $service_start = "/etc/rc.d/$service_name start"
            $service_stop = "/etc/rc.d/$service_name stop"
        }
        default: {
            $package_name = 'openssh-server'
            $service_name = 'ssh'
            $service_command = "/usr/sbin/service $service_name"
            $service_start = "/usr/sbin/service $service_name start"
            $service_stop = "/usr/sbin/service $service_name stop"
        }
    }

    # This can be used to work around startup scripts that don't have a proper 
    # "status" target.
    $service_hasstatus = $::lsbdistcodename ? {
        default => 'true',
    }
}
