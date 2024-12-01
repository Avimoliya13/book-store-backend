# AWS Provider Configuration
provider "aws" {
  region = "us-east-1"  # Adjust the region as needed
}

# Security Group to allow SSH, HTTP, and HTTPS traffic
resource "aws_security_group" "web_access" {
  name        = "web_access"
  description = "Allow SSH, HTTP, and HTTPS access"
  
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

# EC2 Instance configuration
resource "aws_instance" "backend_instance" {
  ami           = "ami-00fe47890705a7062"
  instance_type = "t2.micro"
  key_name      = "book-store-backend"
  security_groups = [aws_security_group.web_access.name]

  # Modified user data to include HTTPS setup
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker nginx -y
              service docker start
              service nginx start
              usermod -a -G docker ec2-user

              # Generate self-signed certificate
              mkdir -p /etc/nginx/ssl
              openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
                -keyout /etc/nginx/ssl/nginx.key \
                -out /etc/nginx/ssl/nginx.crt \
                -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

              # Configure Nginx with SSL
              cat > /etc/nginx/conf.d/default.conf <<'EOL'
              server {
                  listen 80;
                  return 301 https://$host$request_uri;
              }

              server {
                  listen 443 ssl;
                  ssl_certificate /etc/nginx/ssl/nginx.crt;
                  ssl_certificate_key /etc/nginx/ssl/nginx.key;

                  location / {
                      proxy_pass http://localhost:3000;
                      proxy_http_version 1.1;
                      proxy_set_header Upgrade $http_upgrade;
                      proxy_set_header Connection 'upgrade';
                      proxy_set_header Host $host;
                      proxy_cache_bypass $http_upgrade;
                  }
              }
              EOL

              # Restart Nginx
              service nginx restart

              # Pull and run your Docker container
              $(aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 850995544719.dkr.ecr.us-east-1.amazonaws.com)
              docker pull 850995544719.dkr.ecr.us-east-1.amazonaws.com/book-store-backend:latest
              docker run -d -p 3000:3000 850995544719.dkr.ecr.us-east-1.amazonaws.com/book-store-backend:latest
              EOF

  tags = {
    Name = "Backend-Instance"
  }
}

# Output Public IP of EC2 instance
output "instance_public_ip" {
  value = aws_instance.backend_instance.public_ip
}
