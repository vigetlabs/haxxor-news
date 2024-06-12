#=====================================
# Production
#=====================================
resource "aws_eip" "web" {
  instance = aws_instance.web.id

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.web.instance_type
  key_name      = aws_key_pair.ansible.key_name
  subnet_id     = aws_subnet.public_subnets[0].id

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  root_block_device {
    volume_size = local.web.volume_size
  }

  tags = {
    Name = "${module.this.id}"
  }

  lifecycle {
    ignore_changes = [
      ami
    ]
  }
}

resource "aws_security_group" "web" {
  name        = "${module.this.id} Web Server"
  description = "${module.this.id} Web Server security group rules"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = module.this.id
  }
}
