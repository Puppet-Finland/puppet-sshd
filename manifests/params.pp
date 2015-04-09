#
# == Class: sshd::params
#
# Defines some variables based on the operating system
#
class sshd::params {

    include os::params

    case $::osfamily {
        'RedHat': {
            $package_name = 'openssh-server'
            $service_name = 'sshd'
        }
        'Debian': {
            $package_name = 'openssh-server'
            $service_name = 'ssh'
        }
        'FreeBSD': {
            $service_name = 'sshd'
        }
        default: {
            fail("Unsupported operatingsystem ${::operatingsystem}")
        }
    }

    if $::has_systemd == 'true' {
        $service_start = "${::os::params::systemctl} start ${service_name}"
        $service_stop = "${::os::params::systemctl} stop ${service_name}"
    } else {
        $service_start = "${::os::params::service_cmd} ${service_name} start"
        $service_stop = "${::os::params::service_cmd} ${service_name} stop"
    }

    # This can be used to work around startup scripts that don't have a proper 
    # "status" target.
    $service_hasstatus = $::lsbdistcodename ? {
        default => 'true',
    }
}
