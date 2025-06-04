resource "aws_vpc" "demo_vpc" {
  cidr_block = var.cidr_block


  tags = {
    Name = var.aws_vpc_name
  }


}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone

}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo_vpc.id
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}