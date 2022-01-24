variable "gitlab_url" {
  type    = string
  default = "http://ci.diplomproj.ru/"
}

variable "gitlab_token" {
  type = string
}

variable "aws_zone" {
  type    = string
  default = "eu-west-1"
}

data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

provider "aws" {
  region = var.aws_zone
}

resource "aws_security_group" "runner_sec" {
  name = "gitlab runners security"

  ingress {
    from_port   = 22
    to_port     = 22
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

# simple shell executor
resource "aws_instance" "gitlab-runner" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  tags            = { Name : "gitlab-runner" }
  key_name        = "id_rsa"
  security_groups = [aws_security_group.runner_sec.name]
}

output "public_ip" {
  value       = aws_instance.gitlab-runner.public_ip
  description = "The public IP address of the gitlab runner"
}