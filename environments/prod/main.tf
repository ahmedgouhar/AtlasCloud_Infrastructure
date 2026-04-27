
#  # semantically equivalent to all ports

module "vpc" {
  source     = "../../modules/vpc"
  cidr_block = "10.0.0.0/16"
}
module "subnet" {
  source = "../../modules/subnet"

  vpc_id               = module.vpc.vpc_id
  public_subnet_cidrs  = var.public_subnet_cidrs
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs

  subnet_count = 2
}

# module "ec2" {
#   source = "../../modules/ec2"
#   instance_count = var.instance_count
#   ami = data.aws_ami.latest.id 
#   public_subnet_ids  = module.subnet.public_subnet_ids
#   sg_id              = module.security_group.sg_id
# }
module "IGW" {
  source = "../../modules/IGW"
  vpc_id = module.vpc.vpc_id

}
module "route_table" {
  source = "../../modules/route-table"

  vpc_id             = module.vpc.vpc_id
  igw_id             = module.IGW.igw_id
  public_subnet_ids  = module.subnet.public_subnet_ids
  nat_id             = module.nat.nat_id
  private_subnet_ids = module.subnet.private_subnet_ids

}
module "security_group" {
  source = "../../modules/security_group"
  vpc_id = module.vpc.vpc_id
}
module "alb" {
  source = "../../modules/alb"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.subnet.public_subnet_ids
  sg_id             = module.security_group.sg_id
  alb_logs_bucket   = module.s3.alb_logs_bucket_name


}
module "s3" {
  source         = "../../modules/s3"
  cloudfront_arn = ""
}

module "nat" {
  source           = "../../modules/NAT"
  public_subnet_id = module.subnet.public_subnet_ids[0]
}

module "iam" {
  source = "../../modules/iam"

  role_name    = "cleanora-ec2-role"
  profile_name = "cleanora-ec2-profile"
}
module "asg" {
  source = "../../modules/ASG"

  ami                   = data.aws_ami.latest.id
  sg_id                 = module.security_group.sg_id
  private_subnet_ids    = module.subnet.private_subnet_ids
  target_group_arn      = module.alb.target_group_arn
  instance_profile_name = module.iam.instance_profile_name
}
module "sns" {
  source = "../../modules/sns"

  topic_name = "cleanora-alerts"
  email_endpoints = [
    "waela8214@gmail.com"
  ]
}
module "cloudwatch" {
  source        = "../../modules/cloudwatch"
  alarm_actions = [module.sns.sns_topic_arn]
  asg_name      = module.asg.asg_name
  alb_arn       = module.alb.arn

}
module "waf" {
  source  = "../../modules/waf"
  alb_arn = module.alb.arn
}

