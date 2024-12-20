provider "aws" {
  region = "eu-west-3"  # Paris
}

resource "aws_instance" "mlops_server" {
  ami           = "ami-07dc1ccdcec3b4eab"  # Ton ID d'AMI
  instance_type = "t2.micro"  # Type d'instance éligible au Free Tier

  tags = {
    Name = "mlops-server"
  }

  # Spécifie le nom de ta clé SSH (sans l'extension .pem)
  key_name = "my-aws-key"  # Le nom de ta clé SSH dans AWS

  vpc_security_group_ids = [aws_security_group.allow_ssh_and_http.id]

  # Provisionner l'instance avec remote-exec
  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y docker",
      "sudo service docker start"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"  # Utilisateur par défaut pour Amazon Linux
      private_key = file("C:/Users/brude/Documents/Cours_EFREI/Cours_M2/DEVOPS_MLOPS/my-aws-key.pem")  # Chemin absolu vers ta clé privée
      host        = self.public_ip  # Utilise l'IP publique de l'instance
    }
  }
}

resource "aws_security_group" "allow_ssh_and_http" {
  name        = "allow_ssh_and_http"
  description = "Autoriser SSH et HTTP/HTTPS"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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

output "public_ip" {
  value       = aws_instance.mlops_server.public_ip
  description = "Adresse IP publique de l'instance"
}
