resource "aws_iam_role_policy" "s3_policy" {
  name = "s3_policy"
  role = aws_iam_role.s3_role.id
  policy = "${file("${local.module_path}/../nginx/s3-policy.json")}"
}

resource "aws_iam_role" "s3_role" {
  name = "s3_role"
  assume_role_policy = "${file("${local.module_path}/../nginx/s3-assume-policy.json")}"
}


resource "aws_iam_instance_profile" "s3_profile" {
  name = "s3_bucket_profile"
  role = aws_iam_role.s3_role.name
}



#resource "aws_iam_role_policy" "ec2_policy" {
#  name = "ec2_policy"
#  role = aws_iam_role.ec2_role.id

#  policy = "${file("${local.module_path}/../nginx/ec2-policy.json")}"

#}

#resource "aws_iam_role" "ec2_role" {
#  name = "ec2_role"

#  assume_role_policy = "${file("${local.module_path}/../nginx/ec2-assume-policy.json")}"

#}


#resource "aws_iam_instance_profile" "ec2_profile" {
#  name = "ec2_describe_profile"
#  role = aws_iam_role.ec2_role.name
#}