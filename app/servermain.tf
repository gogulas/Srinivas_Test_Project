module "servers" {
  source             = "./modules/servers"
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_id  = module.vpc.private_subnet_ids[0]
  security_group_ids = [aws_security_group.ec2_sg.id]
  key_name           = "my-key"
  ami_id             = "ami-0abcdef1234567890" # Use Amazon Linux AMI for example
  instance_type      = "t2.micro"
}

resource "aws_instance" "public" {
  count         = 2
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_ids[count.index]
  key_name      = var.key_name
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "public-instance-${count.index + 1}"
  }
}

resource "aws_instance" "private" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  key_name      = var.key_name
  vpc_security_group_ids = var.security_group_ids
  associate_public_ip_address = false

  tags = {
    Name = "private-instance"
  }
}

resource "aws_security_group" "ec2_sg" {
  name   = "ec2-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_PUBLIC_IP/32"] # Replace with your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

