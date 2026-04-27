resource "aws_s3_bucket" "cleanora_bucket" {
  bucket = "cleanora-terraform-state"

  tags = {
    Name = "cleanora-state"
  }
  }
  
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.cleanora_bucket.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.cleanora_bucket.id
  
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "allow_cf" {
  bucket = aws_s3_bucket.cleanora_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
       Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.cleanora_bucket.arn}/*"

        Condition = {
          StringEquals = {
            "AWS:SourceArn" = var.cloudfront_arn
          }
        }
      }
    ]
  })
}


resource "aws_s3_bucket" "alb_logs" {
  bucket = "cleanora-alb-logs-prod"

  tags = {
    Name = "cleanora-state"
  }
}

resource "aws_s3_bucket_policy" "alb_logs" {
    bucket = aws_s3_bucket.alb_logs.id


  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = data.aws_elb_service_account.main.arn
      }
      Action = "s3:PutObject"
      Resource = "${aws_s3_bucket.alb_logs.arn}/alb/*"
    }]
  })
}






resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.cleanora_bucket.id
  key          = "index.html"
  source       = "${path.root}/index.html"
  content_type = "text/html"
}
resource "aws_s3_object" "cv" {
  bucket = aws_s3_bucket.cleanora_bucket.id

  key    = "cv.pdf"
  source = "${path.root}/cv.pdf"

  content_type = "application/pdf"
}
resource "aws_s3_object" "saa" {
  bucket = aws_s3_bucket.cleanora_bucket.id

  key    = "saa.pdf"
  source = "${path.root}/saa.pdf"

  content_type = "application/pdf"
}

# resource "aws_s3_bucket_versioning" "versioning" {
#   bucket = aws_s3_bucket.cleanora_bucket.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }