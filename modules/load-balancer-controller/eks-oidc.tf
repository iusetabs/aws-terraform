data "tls_certificate" "eks-cluster-tls-certificate" {
  url = var.cluster_oidc_issuer
}

resource "aws_iam_openid_connect_provider" "eks-cluster-oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks-cluster-tls-certificate.certificates[0].sha1_fingerprint]
  url             = var.cluster_oidc_issuer
}