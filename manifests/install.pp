#
# == Class: sshd install
#
# Install sshd
#
class sshd::install inherits sshd::params {

    # Sshd is bundled with FreeBSD and can't be installed separately
    if $::operatingsystem != 'FreeBSD' {
        package { 'sshd-openssh-server':
            ensure => installed,
            name   => $::sshd::params::package_name,
        }
    }
}
