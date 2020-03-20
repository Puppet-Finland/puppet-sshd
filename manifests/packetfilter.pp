#
# == Class: sshd::packetfilter
#
# Setup packet filtering rules for sshd
#
class sshd::packetfilter
(
    Integer          $port,
    Optional[String] $allow_address_ipv4 = undef,
    Optional[String] $allow_address_ipv6 = undef,
    Optional[String] $limit = undef,

) inherits sshd::params
{
    @firewall { '001 ipv4 accept ssh port':
        provider => 'iptables',
        chain    => 'INPUT',
        proto    => 'tcp',
        source   => $allow_address_ipv4,
        dport    => $port,
        action   => 'accept',
        limit    => $limit,
        tag      => 'default',
    }

    @firewall { '001 ipv6 accept ssh port':
        provider => 'ip6tables',
        chain    => 'INPUT',
        proto    => 'tcp',
        source   => $allow_address_ipv6,
        dport    => $port,
        action   => 'accept',
        limit    => $limit,
        tag      => 'default',
    }
}
