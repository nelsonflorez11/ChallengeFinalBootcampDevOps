
resource "aws_launch_template" "example" {
  name_prefix   = "example"
  image_id      = "ami-02ea247e531eb3ce6"
  instance_type = "t1.micro"
}

resource "aws_autoscaling_group" "example" {
  availability_zones = ["us-west-1c"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.example.id
      }

      override {
        instance_type     = "t2.nano"
        weighted_capacity = "3"
      }

      override {
        instance_type     = "t2.small"
        weighted_capacity = "2"
      }
    }
  }
}