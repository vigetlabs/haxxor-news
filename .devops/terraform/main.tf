locals {
  vpc = {
    cidr_block = "10.0.0.0/16"

    availability_zones = ["us-east-1a"]
    public_subnets     = ["10.0.100.0/24"]
  }

  web = {
    instance_type = "t3.medium"
    volume_size   = 30
  }
}

resource "aws_key_pair" "ansible" {
  key_name   = module.this.id
  public_key = file("../keys/system/ansible.pub")
}
