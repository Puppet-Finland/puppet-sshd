#
# == Class: sshd::packetfilter
#
# Setup packet filtering rules for sshd
#
class sshd::packetfilter
(
    Integer          $port,
    Optional[String] $limit

) inherits sshd::params
{
    @firewall { '001 ipv4 accept ssh port':
        provider => 'iptables',
        chain    => 'INPUT',
        proto    => 'tcp',
        dport    => $port,
        action   => 'accept',
        limit    => $limit,
        tag      => 'default',
    }

    @firewall { '001 ipv6 accept ssh port':
        provider => 'ip6tables',
        chain    => 'INPUT',
        proto    => 'tcp',
        dport    => $port,
        action   => 'accept',
        limit    => $limit,
        tag      => 'default',
    }
}
