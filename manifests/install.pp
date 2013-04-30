#
# == Class: sshd install
#
# Install sshd
#
class sshd::install {

    include sshd::params

    package { 'sshd-openssh-server':
        name   => $sshd::params::package_name,
        ensure => installed,
    }
}
