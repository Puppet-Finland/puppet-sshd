#
# == Class: sshd
#
# Install and configure sshd
#
# == Params:
# 
# [*listenaddress*]
#   Local IP-addresses sshd binds to. Defaults to "0.0.0.0" (all interfaces).
# [*port*]
#   Port on which sshd listens on. Defaults to 22.
# [*permitrootlogin*]
#   Allow root logins (yes/no). Defaults to "yes".
# [*passwordauthentication*]
#   Allow logins using password (yes/no). Defaults to "yes".
# [*monitor_email*]
#   Email address where local service monitoring software sends it's reports to.
#   Defaults to top scope variable $::servermonitor.
#
# == Examples
#
# class { 'sshd':
#   permitrootlogin => 'yes',
#   passwordauthentication => 'no'
# }
# 
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
# Samuli Seppänen <samuli@openvpn.net>
# Mikko Vilpponen <vilpponen@protecomp.fi>
#
# == License
#
# BSD-lisence
# See file LICENSE for details
#
class sshd(
    $listenaddress          = '0.0.0.0',
    $port                   = 22,
    $permitrootlogin        = 'yes',
    $passwordauthentication = 'yes',
    $monitor_email = $::servermonitor
)
{

# Hiera does not seems to allow any clean way to exclude classes that have 
# already been defined at lower levels of the hierarchy. The method below allows 
# us to define
#
# "manage_sshd: 'false'
#
# in the node's yaml/json file to disable management of this particular class. A 
# cleaner approach implemented at the Hiera level would be most welcome...
#
if hiera('manage_sshd', 'true') != 'false' {

    include sshd::install

    class { 'sshd::config':
        listenaddress => $listenaddress,
        port => $port,
        permitrootlogin => $permitrootlogin,
        passwordauthentication => $passwordauthentication,
    }

    include sshd::service

    if tagged('packetfilter') {
        class { 'sshd::packetfilter':
            port => $port
        }
    }

    if tagged('monit') {
        class { 'sshd::monit':
            monitor_email => $monitor_email,
        }
    }
}
}
