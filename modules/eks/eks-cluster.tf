resource "aws_eks_cluster" "eks_cluster" {

    name    = var.cluster_name
    role_arn = aws_iam_role.eks-iam-role.arn
    version = var.cluster_version

    vpc_config {
        endpoint_private_access = false
        endpoint_public_access  = true
        subnet_ids = concat(var.private_subnets, var.public_subnets)
        security_group_ids = [
            aws_security_group.cluster_security_group.id
        ]
    }

    depends_on = [
        aws_iam_role.eks-iam-role,
    ]


    # Use KMS encryption key for k8s secrets
    # https://aws.amazon.com/kms/
    encryption_config  {
        resources = ["secrets"]

        provider {
            key_arn = aws_kms_key.cluster_envelope_key.arn
        }
    }

}
