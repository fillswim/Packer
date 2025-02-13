packer {
  required_plugins {
    openstack = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/openstack"
    }
  }
}

source "openstack" "test_ubuntu" {
  image_name          = "test-ubuntu-by-packer"

  identity_endpoint   = var.openstack_identity_endpoint
  username            = var.openstack_username
  password            = var.openstack_password
  insecure            = "true"

  region              = "RegionOne"
  domain_name         = "Default"
  tenant_name         = "admin"

  flavor              = "m1.medium"
  ssh_username        = "ubuntu"
  source_image        = "810fc17b-34c4-4b2e-b525-b5ab6f87c422"
  networks            = ["806ba795-c881-491d-9bf1-b7e3c4e8cc90"]
  floating_ip_network = "c6af89f4-2163-4276-a348-1ca989c232ec"
}

build {
  name    = "ubuntu-by-packer"
  sources = ["source.openstack.test_ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y chrony"
    ]
  }

}

