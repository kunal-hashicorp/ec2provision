provider "aws" {
  region = var.aws_region
}

# Define a local variable for AMI
locals {
  ami_id = "ami-0d016af584f4febe3" # Replace with a valid AMI in your region
}

# EC2 Instance Resource
resource "aws_instance" "example" {
  ami                    = local.ami_id
  instance_type          = var.instance_type
  iam_instance_profile   = "ec2-instance-profile"  # Hardcoded to avoid data source

  tags = {
    Name = "TerraformEC2"
  }
}

# Output Instance ID
output "instance_id" {
  value = aws_instance.example.id
}
