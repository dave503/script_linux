Vagrant.configure("2") do |config|
    config.vm.define "server" do |server|
      if ENV['VM_IMAGE'] == "centos/8" then
        server.vm.box = "centos/8"
      elsif
        server.vm.box = "generic/debian10"
      end
      server.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"
      server.vm.provision "file", source: "~/.ssh/id_rsa", destination: "~/.ssh/supersecret"
      server.vm.provision "shell", inline: <<-SHELL
          cat /home/vagrant/.ssh/me.pub >> /home/vagrant/.ssh/authorized_keys
        SHELL
      server.vm.provision "shell", inline: <<-SHELL
          cat /home/vagrant/.ssh/supersecret >> /home/vagrant/.ssh/id_rsa
        SHELL
      server.vm.network "public_network", ip: ENV['SERVER_IP']
    end
  end