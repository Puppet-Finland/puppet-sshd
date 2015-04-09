#
# == Class: sshd install
#
# Install sshd
#
class sshd::install inherits sshd::params {

    # Sshd is bundled with FreeBSD and can't be installed separately
    if $::operatingsystem != 'FreeBSD' {
        package { 'sshd-openssh-server':
            name   => $::sshd::params::package_name,
            ensure => installed,
        }
    }
}
