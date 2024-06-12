#=====================================
# VPC
#=====================================
resource "aws_vpc" "vpc" {
  cidr_block = local.vpc.cidr_block
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${module.this.id} - Internet Gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${module.this.id} - Public Access"
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(local.vpc.public_subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(local.vpc.public_subnets, count.index)
  availability_zone       = element(local.vpc.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${module.this.id} - Public ${element(local.vpc.availability_zones, count.index)}"
  }
}

resource "aws_route_table_association" "public_subnets" {
  count = length(local.vpc.public_subnets)

  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public.id
}
