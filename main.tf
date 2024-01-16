terraform { 
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.32.1" }
  } 
}

# Define the local variables for the root module
locals {
  ami_id = "ami-0c7217cdde317cfec"
  vpc_id = "vpc-0e86b5e15b13e9e8b"
  ssh_user = "ubuntu"
  key_name = "ledjo"
  private_key_path = "/home/ledjo/Documents/Task/ledjo.pem"
}

# Creates the EC2 Security Group with Inbound and Outbound rules.
resource "aws_security_group" "polkadot_nodes_sg" {
  name = "polkadot_nodes_sg"
  vpc_id = local.vpc_id
	
	# This will allow us to SSH into the instance for Ansible
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# This creates the EC2 instance and makes an initial SSH connection.
resource "aws_instance" "polkadot_node" {
  count = var.instance_count
  ami = local.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.polkadot_nodes_sg.id]
  key_name = local.key_name
  tags = {
    Name = "polkadot-node-${count.index + 1}"
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = local.ssh_user
    private_key = file(local.private_key_path)
    timeout = "4m"
  }

}

