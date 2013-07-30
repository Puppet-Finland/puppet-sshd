#
# == Class: sshd::monit
#
# Setups monit rules for sshd
#
class sshd::monit(
    $monitor_email
)
{
    monit::fragment { 'sshd-sshd.monit':
        modulename => 'sshd',
    }
}
