#
# == Class: sshd::packetfilter
#
# Setup packet filtering rules for sshd
#
class sshd::packetfilter($port) {

    firewall { '001 ipv4 accept ssh port':
        provider => 'iptables',
        chain  => 'INPUT',
        proto => 'tcp',
        port => "${port}",
        action => 'accept',
    }

    firewall { '001 ipv6 accept ssh port':
        provider => 'ip6tables',
        chain  => 'INPUT',
        proto => 'tcp',
        port => "${port}",
        action => 'accept',
    }
}
