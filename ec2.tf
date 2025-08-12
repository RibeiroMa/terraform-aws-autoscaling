 data "aws_ami" "ubuntu" {
    owners = [ "amazon" ]
    most_recent = true
    name_regex = "ubuntu"
   
   filter {
     name = "architecture"
     values = ["x86_64"]
   }
 }

 resource "aws_launch_template" "this" {
    name_prefix = "terraform"
    image_id = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    user_data = filebase64("ec2_setup.sh")

    monitoring {
      enabled = true
    }

    network_interfaces {
      associate_public_ip_address = false
      delete_on_termination = true
      security_groups = [ aws_security_group.autoscaling.id ]
    }
 }

resource "aws_autoscaling_group" "this" {
  name = "terraform-asg"
  vpc_zone_identifier = [ aws_subnet.this["pvt_a"].id, aws_subnet.this["pvt_b"].id ] 
  max_size = 4
  min_size = 2
  health_check_grace_period = 240
  health_check_type = "ELB"
  force_delete = true
  target_group_arns = [ aws_lb_target_group.this.id ]

  launch_template {
    id = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }
}

resource "aws_autoscaling_policy" "scaleup" {
    name = "Scale up"
    autoscaling_group_name = aws_autoscaling_group.this.name
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = 1
    cooldown = 180
    policy_type = "SimpleScaling"
  
}

resource "aws_autoscaling_policy" "scaledown" {
    name = "Scale down"
    autoscaling_group_name = aws_autoscaling_group.this.name
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = -1
    cooldown = 180
    policy_type = "SimpleScaling"
  
}

