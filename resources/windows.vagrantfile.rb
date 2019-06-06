# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.guest = :windows
  config.vm.communicator = "winrm"
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: 'rdp', auto_correct: true

  config.vm.provider :hyperv do |hyperv, override|
    hyperv.linked_clone = true
  end
end
