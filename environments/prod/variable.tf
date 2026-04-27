
variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}
variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.12.0/24"]

}
variable "availability_zones" {
  type = list(string)
  default = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c"
  ]
}

variable "instance_count" {
  type    = number
  default = 1
}