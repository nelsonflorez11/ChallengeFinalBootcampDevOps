data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_template" "Web-BootcampDevOps" {
  name_prefix   = "Web-BootcampDevOps"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t1.micro"
  key_name = "BootcampDevOps"
  user_data = filebase64("./scripts/BootcampDevOps.sh")
  
}

resource "aws_autoscaling_group" "BootcampDevOps" {
  name               = "BootcampDevOps"
  availability_zones = ["us-west-1c"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.Web-BootcampDevOps.id
      }

      override {
        instance_type     = "t2.nano"        
      }

      override {
        instance_type     = "t2.small"        
      }
    }
  }
}