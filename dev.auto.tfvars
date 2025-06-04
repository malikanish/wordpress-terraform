
ec2_volume_config = {
  size = 30
  type = "gp3"
}
aws_region = "us-east-1"

aws_instance_type = "t2.micro"
aws_instance_config = {
  name = "t2.micro"
}

aws_vpc_name = "anish_vpc"

aws_subnet_name = "Anish public-subnet"
aws_subnet_name1 ="anish-public-subnet1"


ec2_volume_config = {
  size = 30
  type = "gp3"
}
aws_region = "us-east-1"

aws_instance_type = "t2.micro"
aws_vpc_name      = "anish_vpc"

aws_subnet_name      = "Anish public-subnet"
aws_internet_gateway = "Anish_igw"

default_route = "0.0.0.0/0"
cidr_block    = "10.0.0.0/16"
availability_zone = "us-east-1b"
anish-sg = "anish_sg"