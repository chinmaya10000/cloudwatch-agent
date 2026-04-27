#IAM Role
resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = "ec2-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

# Attach CloudWatch Policy
resource "aws_iam_role_policy_attachment" "cloudwatch_policy" {
  role = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_cloudwatch_role.name
}

# Attach to Existing Instance
# resource "aws_iam_instance_profile_association" "my_instance" {
#   instance_id          = var.instance_id
#   iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
# }