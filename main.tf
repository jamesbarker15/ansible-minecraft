provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-01dd271720c1ba44f"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.minecraft.name]
    key_name = "minecraft"
    tags = {
        Name = "Minecraft Server"
        }
}

resource "aws_security_group" "minecraft" {
    name = "Allow Minecraft and SSH"

    ingress {
        from_port = 19132
        to_port = 19132
        protocol = "UDP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
     ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
}

output "ec2_public_ip" {
    value = aws_instance.ec2.public_ip
}
