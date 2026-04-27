
variable "igw_id" {}
variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "nat_id" {}
variable "private_subnet_ids" {
  type = list(string)
}