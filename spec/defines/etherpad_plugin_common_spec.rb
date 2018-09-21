require 'spec_helper'

describe 'etherpad::plugins::common' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:pre_condition) do
        pp = <<-EOS
        class { 'etherpad':
          ensure            => 'present',
          database_type     => 'mysql',
          database_name     => 'etherpad',
          database_user     => 'etherpad',
          database_password => '37h3rp4d',
          users             => {
            admin => {
              password => 's3cr3t',
              is_admin => true,
            },
            user  => {
              password => 'secret',
              is_admin => false,
            },
          },
        }
        EOS
        pp
      end
      let(:facts) do
        facts
      end
      let(:title) { 'ep_myplugin' }

      it { is_expected.to compile.with_all_deps }
      it {
        is_expected.to contain_nodejs__npm('ep_myplugin').with(
          'ensure'   => 'present',
          'target'   => '/opt/etherpad',
          'package'  => 'ep_myplugin',
          'user'     => 'etherpad',
          'home_dir' => '/opt/etherpad'
        )
      }
    end
  end
end
