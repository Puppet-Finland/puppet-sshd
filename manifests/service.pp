#
# == Class: sshd::service
#
# Enable sshd on boot
#
class sshd::service inherits sshd::params {

    service { 'sshd-service':
        name    => $::sshd::params::service_name,
        enable  => true,
        require => Class['sshd::install'],
    }
}
