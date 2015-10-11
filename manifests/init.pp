#
# == Class: sshd
#
# Install and configure sshd
#
# == Parameters
#
# [*manage*]
#   Whether to manage sshd using Puppet or not. Valid values are 'yes' (default) 
#   and 'no'.
# [*manage_config*]
#   Whether to manage sshd configuration using Puppet or not. Valid values are 
#   'yes' (default) and 'no'.
# [*listenaddress*]
#   Local IP-addresses sshd binds to. This can be an string containing one bind 
#   address or an array containing one or more. Defaults to "0.0.0.0" (all 
#   IPv4 interfaces).
# [*port*]
#   Port on which sshd listens on. Defaults to 22.
# [*permitrootlogin*]
#   Allow root logins (yes/no). Defaults to "yes".
# [*passwordauthentication*]
#   Allow logins using password (yes/no). Defaults to "yes".
# [*kerberosauthentication*]
#   Allow Kerberos authentication. This is required when using pam_winbind and 
#   logging in using credentials from Samba4 / Active Directory domain. Valid 
#   values are 'yes' and 'no' (default).
# [*monitor_email*]
#   Email address where local service monitoring software sends it's reports to.
#   Defaults to top scope variable $::servermonitor.
#
# == Examples
#
#   class { 'sshd':
#       permitrootlogin => 'yes',
#       passwordauthentication => 'no'
#   }
# 
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# Samuli Seppänen <samuli@openvpn.net>
#
# Mikko Vilpponen <vilpponen@protecomp.fi>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class sshd
(
    $manage                 = 'yes',
    $manage_config          = 'yes',
    $listenaddress          = '0.0.0.0',
    $port                   = 22,
    $permitrootlogin        = 'yes',
    $passwordauthentication = 'yes',
    $kerberosauthentication = 'no',
    $monitor_email = $::servermonitor
)
{

if $manage == 'yes' {

    $listenaddresses = any2array($listenaddress)

    include ::sshd::install

    if $manage_config == 'yes' {
        class { '::sshd::config':
            listenaddresses        => $listenaddresses,
            port                   => $port,
            permitrootlogin        => $permitrootlogin,
            passwordauthentication => $passwordauthentication,
            kerberosauthentication => $kerberosauthentication,
        }
    }

    include ::sshd::service

    if tagged('packetfilter') {
        class { '::sshd::packetfilter':
            port => $port
        }
    }

    if tagged('monit') {
        class { '::sshd::monit':
            monitor_email => $monitor_email,
        }
    }
}
}
