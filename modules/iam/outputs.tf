output "ec2_iam_role_policy_name" {
   value = aws_iam_role_policy.ec2_policy.name
}

output "ec2_iam_role_name" {
   value = aws_iam_role.ec2_role.name
}

output "ec2_iam_profile_name" {
   value = aws_iam_instance_profile.ec2_profile.name
}

output "s3_iam_role_policy_name" {
   value = aws_iam_role_policy.s3_policy.name
}

output "s3_iam_role_name" {
   value = aws_iam_role.s3_role.name
}

output "s3_iam_profile_name" {
   value = aws_iam_instance_profile.s3_profile.name
}

