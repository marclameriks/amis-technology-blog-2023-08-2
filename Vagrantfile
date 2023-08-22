Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"
  
  config.vm.define "ubuntu_vsc_terraform_azurecli" do |ubuntu_vsc_terraform_azurecli|
    
    config.vm.synced_folder "C:\\My\\AMIS\\MySharedFolder", "/mnt/mysharedfolder", automount: true
    
    config.vm.provider "virtualbox" do |vb|
        vb.name = "Ubuntu Desktop, Visual Studio Code, Terraform and Azure CLI"
        vb.memory = "8192"
        vb.cpus = "2"
        vb.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
        vb.customize ['modifyvm', :id, '--vram', '16']
        vb.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]
        vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
        vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", "0", "--device", "0", "--type", "dvddrive", "--medium", "C:\\My\\App\\Oracle\\VirtualBox\\VBoxGuestAdditions.iso"]
        vb.gui = true
    
    args = []
    config.vm.provision "ubuntu_etc shell script", type: "shell",
        path: "scripts/ubuntu_etc.sh",
        args: args
    
    args = []
    config.vm.provision "fix_vboxguestadditions shell script", type: "shell",
        path: "scripts/fix_vboxguestadditions.sh",
        args: args
    end
    
  end

end
