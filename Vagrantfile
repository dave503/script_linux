Vagrant.configure("2") do |config|
    config.vm.define "server" do |server|
      server.vm.box = "centos/8"
      server.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"
      server.vm.provision "shell", inline: <<-SHELL
          cat /home/vagrant/.ssh/me.pub >> /home/vagrant/.ssh/authorized_keys
        SHELL
      server.vm.network "public_network", ip: ENV['SERVER_IP']
    end
  end