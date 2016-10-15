# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
    N = 2
    (1..N).each do |machine_id|
        config.vm.define "box#{machine_id}" do |machine|
            machine.vm.box = "ubuntu/trusty64"
            machine.vm.hostname = "box#{machine_id}"
            machine.vm.network "public_network", bridge: ENV.fetch('VAGRANT_NETWORK_IFACE', 'em1')

            if machine_id == N
                machine.vm.provision :ansible do |ansible|
                    ansible.playbook = 'syncthing.yml'
                    ansible.sudo = true
                    ansible.limit = 'all'
                    ansible.groups = {
                        'all' => (1..N).map{ |t| "box%d" % t },
                        'syncthing' => (1..N).map{ |t| "box%d" % t },
                        'all:vars' => {
                            'ip_address' => '{{ facter_ipaddress_eth1 }}',
                            'syncthing_group' => 'test-group',
                        }
                    }
                end
            end
        end
    end
end
