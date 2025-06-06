
variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "ec2_volume_config" {

  type = object({
    size = number
    type = string
  })
  description = "the type and sixe of volumes are in size and type"

  default = {
    size = 10
    type = "gp3"
  }
}

variable "aws_instance_type" {
  type = string

}


variable "aws_vpc_name" {
  type = string

}

variable "aws_subnet_name" {
  type = string

}

variable "aws_internet_gateway" {

}
variable "default_route" {

}
variable "cidr_block" {

}
variable "availability_zone" {
  
}
variable "anish-sg" {
  
}