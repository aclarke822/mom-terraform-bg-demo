#Build instructions
#terraform apply
#packer build -var vpc_id=$(terraform output --raw vpc_id) -var subnet_id=$(terraform output --raw private_subnet_id) .

build {
  sources = ["source.amazon-ebs.linux"]

  provisioner "file" {
    source      = "assets/index.html"
    destination = "/tmp/index.html"
  }

  provisioner "shell" {
    scripts = [
      "shell/init.sh",
    ]
  }
}