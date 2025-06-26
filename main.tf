provider "aws" {
  region = var.aws_region
}

# Fetch latest Ubuntu AMI dynamically (optional, uncomment if needed)
# data "aws_ami" "latest_ubuntu" {
#   most_recent = true
#   owners      = ["099720109477"] # Canonical (Ubuntu)
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }
# }

# Define a local variable for AMI
locals {
  # ami_id = data.aws_ami.latest_ubuntu.id
  ami_id = "ami-0d016af584f4febe3"
}

# Look up existing IAM Role
data "aws_iam_role" "ec2_role" {
  name = "ec2-instance-role_ks"
}

# Look up existing IAM Instance Profile
data "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
}

# EC2 Instance Resource
resource "aws_instance" "example" {
  ami                  = local.ami_id
  instance_type        = var.instance_type
  iam_instance_profile = data.aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "TerraformEC2"
  }
}

# Output Instance ID
output "instance_id" {
  value = aws_instance.example.id
}
