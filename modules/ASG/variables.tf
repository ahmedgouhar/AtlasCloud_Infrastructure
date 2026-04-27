variable "ami" {}
variable "sg_id" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "target_group_arn" {
  type = string
}
variable "instance_profile_name" {
  type = string
}