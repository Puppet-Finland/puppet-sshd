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
        }
        'Debian': {
            $package_name = 'openssh-server'
            $service_name = 'ssh'
        }
        default: {
            $package_name = 'openssh-server'
            $service_name = 'ssh'
        }
    }
}
