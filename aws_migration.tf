# Provider Configuration
provider "aws" {
  region = "us-east-1" # Change this to your desired AWS region
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# Create Subnet
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a" # Change this to your desired availability zone

  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-1"
  }
}

# Create EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI; Change this to your desired AMI
  instance_type = "t2.micro"

  subnet_id = aws_subnet.subnet1.id

  tags = {
    Name = "example-instance"
  }
}
