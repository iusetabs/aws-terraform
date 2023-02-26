resource "aws_kms_key" "cluster_envelope_key" {
  description             = "${var.cluster_name}-master-key"
  deletion_window_in_days = 7 # Minimum time before key is deleted
}
