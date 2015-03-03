require 'spec_helper'

describe 'sanoid::default' do
  context 'on FreeBSD' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'freebsd', version: '10.0')
        .converge(described_recipe)
    end

    it 'installs p5-Config-IniFiles' do
      expect(chef_run).to install_package('p5-Config-IniFiles')
    end
    it 'installs p5-libwww' do
      expect(chef_run).to install_package('p5-libwww')
    end
    it 'creates sanoid executable' do
      expect(chef_run).to create_remote_file_if_missing('/usr/local/bin/sanoid')
        .with(owner: 'root')
        .with(group: 'wheel')
        .with(mode: '0750')
      expect(chef_run).to_not create_remote_file_if_missing('/usr/local/bin/sanoid')
        .with(owner: 'veggie-bacon')
        .with(group: 'veggie-bacon')
        .with(mode: '0777')
    end
    it 'creates syncoid executable' do
      expect(chef_run).to create_remote_file_if_missing('/usr/local/bin/syncoid')
        .with(owner: 'root')
        .with(group: 'wheel')
        .with(mode: '0750')
      expect(chef_run).to_not create_remote_file_if_missing('/usr/local/bin/syncoid')
        .with(owner: 'veggie-bacon')
        .with(group: 'veggie-bacon')
        .with(mode: '0777')
    end
    it 'creates sanoid conf dir' do
      expect(chef_run).to create_directory('/etc/sanoid')
        .with(owner: 'root')
        .with(group: 'wheel')
        .with(mode: '0750')
    end
    it 'creates a sanoid cron job' do
      expect(chef_run).to create_cron('sanoid')
        .with(minute: '*', hour: '*', day: '*', month: '*', weekday: '*')
      expect(chef_run).to_not create_cron('sanoid')
        .with(minute: '1', hour: '1', day: '*', month: '*', weekday: '*')
    end
  end
end
