# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "Project_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Project_vpc"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "Project_igw" {
  vpc_id = aws_vpc.Project_vpc.id

  tags = {
    Name = "Project-igw"
  }
}

# Create a route table
resource "aws_route_table" "Project_route_table" {
  vpc_id = aws_vpc.Project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Project_igw.id
  }

  tags = {
    Name = "Project-route-table"
  }
}

# Create a security group for the instance
resource "aws_security_group" "Project_sg" {
  name_prefix = "Project-sg"
  vpc_id = aws_vpc.Project_vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Project-sg"
  }
}

# Launch an EC2 instance
resource "aws_instance" "Project_instance" {
  ami = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  user_data = file("user_data.sh")
  key_name = "classkey"
  vpc_security_group_ids = [aws_security_group.Project_sg.id]
  subnet_id = aws_subnet.Project_subnet.id

  tags = {
    Name = "Project-instance"
   }
 }

# Launch an EC2 instance2
resource "aws_instance" "Project_instance2" {
  ami = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  user_data = file("user_data.sh")
  key_name = "classkey"
  vpc_security_group_ids = [aws_security_group.Project_sg.id]
  subnet_id = aws_subnet.Project_subnet2.id

  tags = {
    Name = "Project-instance2"
  }
}

# Create a subnet
resource "aws_subnet" "Project_subnet" {
  vpc_id = aws_vpc.Project_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true


  tags = {
    Name = "Project-subnet"
  }
}

# Create a subnet2
resource "aws_subnet" "Project_subnet2" {
  vpc_id = aws_vpc.Project_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true


  tags = {
    Name = "Project-subnet2"
  }
}


# Associate the route table with the subnet
resource "aws_route_table_association" "Project_rta" {
  subnet_id = aws_subnet.Project_subnet.id
  route_table_id = aws_route_table.Project_route_table.id
}
