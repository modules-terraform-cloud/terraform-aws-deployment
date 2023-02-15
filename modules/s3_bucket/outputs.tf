output "s3_alb_logs_id" {
   value = aws_s3_bucket.s3_alb_logs.id
}

output "s3_access_logs_policy_id" {
   value = aws_s3_bucket_policy.access_logs_policy.id
}

output "s3_acl" {
   value = aws_s3_bucket_acl.s3_acl
}

output "s3_versioning" {
   value = aws_s3_bucket_versioning.versioning
}

output "s3_logging" {
   value = aws_s3_bucket_logging.logging
}