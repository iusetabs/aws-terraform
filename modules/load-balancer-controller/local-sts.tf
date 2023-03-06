data "aws_caller_identity" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
  eks_oidc = replace(replace(var.cluster_endpoint, "https://", ""), "/\\..*$/", "")
}
