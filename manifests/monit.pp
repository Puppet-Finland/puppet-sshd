#
# == Class: sshd::monit
#
# Setups monit rules for sshd
#
class sshd::monit
(
    $monitor_email

) inherits sshd::params
{
    monit::fragment { 'sshd-sshd.monit':
        modulename => 'sshd',
    }
}
