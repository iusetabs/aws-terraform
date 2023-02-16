resource "aws_iam_role" "eks-iam-role" {
    name = "eks-iam-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }]
  })

  tags = {
    FROM-TERRAFORM = "true"
  }
}

resource "aws_iam_role" "eks-workernodes" {
  name = "eks-workernodes"
 
  assume_role_policy = jsonencode({
   Statement = [{
    Action = "sts:AssumeRole"
    Effect = "Allow"
    Principal = {
     Service = "ec2.amazonaws.com"
    }
   }]
   Version = "2012-10-17"
  })

  tags = {
    FROM-TERRAFORM = "true"
  }
}
