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
            $service_command = "/sbin/service $service_name"
            $admingroup = 'root'
        }
        'Debian': {
            $package_name = 'openssh-server'
            $service_name = 'ssh'
            $service_command = "/usr/sbin/service $service_name"
            $admingroup = 'root'
        }
        'FreeBSD': {
            $service_name = 'sshd'
            $service_command = "/usr/sbin/service $service_name"
            $admingroup = 'wheel'
        }
        default: {
            $package_name = 'openssh-server'
            $service_name = 'ssh'
            $service_command = "/usr/sbin/service $service_name"
            $admingroup = 'root'
        }
    }

    # This can be used to work around startup scripts that don't have a proper 
    # "status" target.
    $service_hasstatus = $::lsbdistcodename ? {
        default => 'true',
    }
}
