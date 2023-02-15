locals {
  module_path = "${replace(path.module, "\\", "/")}"
}

resource "aws_iam_role_policy" "s3_policy" {
  name = "s3_policy"
  role = aws_iam_role.s3_role.id
  policy = "${file("${local.module_path}/../s3_bucket/s3-policy.json")}"
}

resource "aws_iam_role" "s3_role" {
  name = "s3_role"
  assume_role_policy = "${file("${local.module_path}/../s3_bucket/s3-assume-policy.json")}"
}


resource "aws_iam_instance_profile" "s3_profile" {
  name = "s3_bucket_profile"
  role = aws_iam_role.s3_role.name
}