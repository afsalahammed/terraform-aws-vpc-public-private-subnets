resource "aws_security_group" "public_sg" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "public-sg"
  description = "Security group for public instances"

  tags = {
    Name = "PublicInstanceSG"
  }
}

resource "aws_security_group_rule" "public_sg_ssh" {
  security_group_id = aws_security_group.public_sg.id
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] # Change this to your IP for security
}

resource "aws_security_group_rule" "public_sg_http" {
  security_group_id = aws_security_group.public_sg.id
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "public_sg_egress" {
  security_group_id = aws_security_group.public_sg.id
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "private_sg" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "private-sg"
  description = "Security group for private instances"

  tags = {
    Name = "PrivateInstanceSG"
  }
}

resource "aws_security_group_rule" "private_sg_ssh" {
  security_group_id = aws_security_group.private_sg.id
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  source_security_group_id = aws_security_group.public_sg.id # Allow SSH only from public SG
}

resource "aws_security_group_rule" "private_sg_egress" {
  security_group_id = aws_security_group.private_sg.id
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}