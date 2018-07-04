#
# == Class: sshd::monit
#
# Setups monit rules for sshd
#
class sshd::monit
(
    String $monitor_email

) inherits sshd::params
{
    @monit::fragment { 'sshd-sshd.monit':
        basename   => 'sshd',
        modulename => 'sshd',
        tag        => 'default',
    }
}
