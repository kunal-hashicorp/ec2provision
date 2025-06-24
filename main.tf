provider "aws" {
  region = var.aws_region
}

# Fetch latest Ubuntu AMI dynamically
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

# Define a local variable for AMI
locals {
  //ami_id = data.aws_ami.latest_ubuntu.id
  ami_id = "ami-0d016af584f4febe3"
}

# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2-instance-role_ks"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF
}

# IAM Policy Attachment for Role (Example: Read-only access to S3)
resource "aws_iam_policy_attachment" "s3_read_access" {
  name       = "s3-read-access"
  roles      = [aws_iam_role.ec2_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

# EC2 Instance Resource
resource "aws_instance" "example" {
  ami                  = local.ami_id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "TerraformEC2"
  }
}

# Output Instance ID
output "instance_id" {
  value = aws_instance.example.id
}
