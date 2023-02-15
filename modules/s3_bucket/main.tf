resource "aws_s3_bucket" "s3_alb_logs" {
  bucket        = "my-tf-log-bucket-diana"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "access_logs_policy" {
  bucket = aws_s3_bucket.s3_alb_logs.id
  policy = data.aws_iam_policy_document.access_logs_doc.json
}

data "aws_iam_policy_document" "access_logs_doc" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["127311923021"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.s3_alb_logs.arn,
      "${aws_s3_bucket.s3_alb_logs.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket        = aws_s3_bucket.s3_alb_logs.id
  acl           = "private"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.s3_alb_logs.id
  
  versioning_configuration {
    status        = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "logging" {
  bucket = aws_s3_bucket.s3_alb_logs.id

  target_bucket = aws_s3_bucket.s3_alb_logs.id
  target_prefix = "log/"
}
