provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "TerraformEC2"
  }
}

output "instance_id" {
  value = aws_instance.example.id
}
