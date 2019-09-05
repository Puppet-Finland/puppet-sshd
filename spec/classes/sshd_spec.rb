require 'spec_helper'

# We set a dummy value for $::lsbdistcodename so that code compilation does not
# fail on RedHat derivatives. We also set the custom fact $::has_systemd to
# true as the actual fact value from systemd module can't be resolved; this is
# good enough as the fact value only affects contents of the monit
# configuration fragment and has no effect on catalog compilation.
#
describe 'sshd' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      case os_facts[:osfamily]
      when 'RedHat'
        extra_facts = { :lsbdistcodename => 'RedHat', :has_systemd => true }
      else
        extra_facts = { :has_systemd => true }
      end

      let(:facts) do
        os_facts.merge(extra_facts)
      end
      let(:params) { { :monitor_email => 'root@localhost' } }
      it { is_expected.to compile }
    end
  end
end
