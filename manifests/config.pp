#
# == Class: sshd::config
#
# Configure sshd
#
class sshd::config(
    $listenaddress,
    $port,
    $permitrootlogin,
    $passwordauthentication
)
{
    file { 'sshd-sshd_config':
        name    => '/etc/ssh/sshd_config',
        content => template('sshd/sshd_config.erb'),
        ensure  => present,
        owner   => root,
        group   => "${::sshd::params::admingroup}",
        mode    => 644,
        require => Class['sshd::install'],
        notify  => Class['sshd::service'],
    }
}
