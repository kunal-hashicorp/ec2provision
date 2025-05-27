variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "iam_role_name" {
  description = "IAM role name for EC2 instance"
  type        = string
  default     = "ec2-instance-role"
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile name"
  type        = string
  default     = "ec2-instance-profile"
}
