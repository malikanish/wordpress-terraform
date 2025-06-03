resource "aws_instance" "web" {
  ami = "ami-084568db4383264d4"
  # associate_public_ip_address = true
  instance_type          = var.aws_instance_type
  subnet_id              = aws_subnet.public_subnet.id
  user_data     = filebase64("userdata.sh")
  vpc_security_group_ids = [aws_security_group.sg.id]
  


  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_config.size
    volume_type           = var.ec2_volume_config.type
  }

  tags = {
    Name = "anish-ec2"
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "Ani-key"  
  public_key = file("/home/anish/Downloads/ani-key.pub")
}


resource "aws_security_group" "sg" {
  name        = "anish-sg"
  description = "Allow  inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.demo_vpc.id
  tags = {
    Name = "anish-sg"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
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


}
