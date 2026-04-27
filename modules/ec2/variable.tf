
variable "instance_count" {}
variable "ami" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "sg_id" {}
