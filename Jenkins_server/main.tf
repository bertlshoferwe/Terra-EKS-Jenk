#vpc
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Jenkis-vpc"
  cidr = var.vpc_cidr

  azs                     = data.aws_availability_zone.azs.names
  public_subnets          = var.public_subnets
  map_public_ip_on_launch = true

  enable_dns_hostnames = true

  tags = {
    name        = "jenkis-vpc"
    Terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    name = "jenkins-subnet"
  }
}

#SG
module "jenkins-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkis-sg"
  description = "Security group for jenkins server"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "http"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    name = "jenkins-sg"
  }
}


#ec2
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "Jenkins-Server"

  instance_type               = var.instance_type
  key_name                    = "Jenkins_Key"
  monitoring                  = true
  vpc_security_group_ids      = [module.jenkins-sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = file("jenkins-install.sh")
  availability_zone           = data.aws_availability_zone.azs.names[0]

  tags = {
    Name        = "Jenkins-Server"
    Terraform   = "true"
    Environment = "dev"
  }
}
 