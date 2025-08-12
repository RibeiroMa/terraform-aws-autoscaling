resource "aws_security_group" "web" {
  name = "Web"
  description = "entrada de trafico publico"
  vpc_id = aws_vpc.this.id

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
    from_port = -1 
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [aws_subnet.this["pvt_a"].cidr_block]
  }

  tags = merge(local.security_group, {Name = "Web Service"})
}


resource "aws_security_group" "alb" {
  name = "alb-sg"
  description = "security group do load balancer"
  vpc_id = aws_vpc.this.id

  ingress {
  from_port = 80 
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
  from_port = 0 
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.security_group, {Name = "Load Balancer"})
}

resource "aws_security_group" "autoscaling" {
  name = "asg"
  description = "security group do autoscaling"
  vpc_id = aws_vpc.this.id

  ingress {
  from_port = 22  
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_groups = [aws_security_group.alb.id]
  }

  egress {
  from_port = 0 
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.security_group, {Name = "Autoscaling"})
}

