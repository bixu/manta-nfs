require 'spec_helper'

describe package('nfs-common'), :if => os[:family] == 'ubuntu' do
	it { should be_installed }
end

describe command('node --version') do
  its(:exit_status) { should eq 0 }
end

describe service('mantanfs') do
	it { should be_enabled }
	it { should be_running }
end

describe command('pgrep portmap'), :if => os[:family] == 'ubuntu' do
	its(:exit_status) { should eq 1 }
end