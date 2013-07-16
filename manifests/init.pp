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
    $passwordauthentication = 'yes'
)
{

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

}
