#
# == Class: sshd::config
#
# Configure sshd
#
class sshd::config
(
    $listenaddress,
    $port,
    $permitrootlogin,
    $passwordauthentication,
    $kerberosauthentication

) inherits sshd::params
{

    # Copy the $host_keys variable to a local variable for template
    $host_keys = $::sshd::params::host_keys

    file { 'sshd-sshd_config':
        ensure  => present,
        name    => '/etc/ssh/sshd_config',
        content => template('sshd/sshd_config.erb'),
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0644',
        require => Class['sshd::install'],
        notify  => Class['sshd::service'],
    }
}
