sshd
====

A general-purpose sshd module for Puppet. Can be used in conjunction 
FreeIPA/sssd. Has optional firewall and monit support.

# Module usage

Use the permissive defaults (password auth and root logins enabled):

    include ::sshd

Disable password auth, root logins and rate-limit connections with iptables and 
ip6tables:

    class { '::sshd':
      permitrootlogin        => 'no',
      passwordauthentication => 'no',
      limit                  => '3/min',
    }

Enable root logins without password when using ssh keys:

    class { '::sshd':
      permitrootlogin        => 'without-password',
      passwordauthentication => 'no',
    }

Integrate with FreeIPA authentication:

    class { '::sshd':
      authorized_keys_from_sssd => true,
      gssapiauthentication      => 'yes',
    }

For further details refer to [init.pp](manifests/init.pp).
