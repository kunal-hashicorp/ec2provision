provider "aws" {
  region = var.aws_region
}

data "aws_ami" "latest_ubuntu" {
  ...
}

locals {
  ami_id = data.aws_ami.latest_ubuntu.id
}

data "aws_iam_role" "ec2_role" {
  name = "ec2-instance-role_ks"
}

data "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
}

resource "aws_instance" "example" {
  ami                  = local.ami_id
  instance_type        = var.instance_type
  iam_instance_profile = data.aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "TerraformEC2"
  }
}

output "instance_id" {
  value = aws_instance.example.id
}
