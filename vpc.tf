resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"

  # tags = {
  #   Name = "Anish VPC"
  # }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  # tags = {
  #   Name = "Anish public-subnet"
  # }
}

# resource "aws_subnet" "public_subnet1" {
#   vpc_id                  = aws_vpc.demo_vpc.id
#   cidr_block              = "10.0.2.0/24"
#   map_public_ip_on_launch = true
#   availability_zone       = "us-east-1a"

#   # tags = {
#   #   Name = "Anish public-subnet1"
#   # }
# }


# resource "aws_subnet" "private_subnet" {
#   vpc_id     = aws_vpc.demo_vpc.id
#   cidr_block = "10.0.1.0/24"
#   tags = {
#     Name = "Anish private-subnet"
#   }
# }

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "Anish-igw"
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}
# resource "aws_route_table_association" "public_subnet1" {
#   subnet_id      = aws_subnet.public_subnet1.id
#   route_table_id = aws_route_table.public_rtb.id
# }

