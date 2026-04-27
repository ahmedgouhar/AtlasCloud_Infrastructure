output "asg_name" {
  value = module.asg.asg_name
}

output "region" {
  value = data.aws_availability_zones.available.names
}
output "ami-id" {
  value = data.aws_ami.latest
}
