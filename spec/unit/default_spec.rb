require 'chefspec'
require 'chefspec/berkshelf'

describe 'fping::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  context 'in a redhat-based platform' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'redhat', :version  => '6.3').converge(described_recipe) }

    before do
      stub_command(/rpm -qa | grep -q '^rpmforge-release-[0-9\.-]'/).and_return(true)
    end

    it 'includes the yum-repoforge::default recipe' do
      expect(chef_run).to include_recipe('yum-repoforge')
    end

  end

  it 'installs the package' do
    expect(chef_run).to install_package('fping')
  end

end
