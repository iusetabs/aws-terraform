resource "aws_security_group" "cluster_security_group" {
  name_prefix = "${var.cluster_name}_sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port = var.instance_https_port
    to_port   = var.instance_https_port
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {
    from_port = var.instance_http_port
    to_port   = var.instance_http_port
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

