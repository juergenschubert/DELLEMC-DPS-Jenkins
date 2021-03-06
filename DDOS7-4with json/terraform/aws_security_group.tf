# define the Ports and the description for ingress rules
locals {
  ingress_rules = [{
    port        = 443
    description = "Port for https"
    },
    {
      port        = 80
      description = "Port for http"
    },
    {
      port        = 22
      description = "Port for ssh"
    },
    {
      port        = 3009
      description = "Port for ReST calls"
    },
    {
      port        = 2049
      description = "Port for DD Boost and replication"
    },
    {
      port        = 2051
      description = "Port for DD Boost and replication"
    }
  ]
}
resource "aws_security_group" "ddvesg" {
  name        = "ddve6_sg_terraform"
  description = "Allow TLS traffic for ddve"
  tags = {
    Name = "DDVE6_sg_terraform"
  }
  egress {
    description = "Scheunentor ipv4"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description      = "Scheunentor ipv6"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      description = ingress.value.description
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port        = ingress.value.port
      to_port          = ingress.value.port
      description      = ingress.value.description
      protocol         = "tcp"
      ipv6_cidr_blocks = ["::/0"]
    }
  }
}
