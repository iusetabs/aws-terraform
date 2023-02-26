resource "aws_lb" "network_load_balancer" {
  name               = "${var.cluster_name}-load-balancer"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnets

  enable_deletion_protection = false

  tags = {
     CREATED_BY = "terraform"
  }

}

resource "aws_lb_listener" "lb_listener_https" {
  load_balancer_arn = aws_lb.network_load_balancer.arn
  port              = "443"
  protocol          = "TCP" 

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg_https.arn
  }
}

resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_lb.network_load_balancer.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg_http.arn
  }
}

resource "aws_lb_target_group" "lb_tg_http" {
  name     = "${var.cluster_name}-tg-http"
  port     = var.instance_http_port
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "lb_tg_https" {
  name     = "${var.cluster_name}-tg-https"
  port     = var.instance_https_port
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

data "aws_instances" "nodegroup_instances" {
  instance_tags = {
   "eks:nodegroup-name" = var.node_group_name
  }
  instance_state_names = ["running", "stopped"]
}

resource "aws_lb_target_group_attachment" "lb_tg_http_attach" {
  for_each = toset(data.aws_instances.nodegroup_instances.ids)

  target_group_arn = aws_lb_target_group.lb_tg_http.arn
  target_id        = "${each.value}"
  port             = aws_lb_listener.lb_listener_http.port
}

resource "aws_lb_target_group_attachment" "lb_tg_https_attach" {
  for_each = toset(data.aws_instances.nodegroup_instances.ids)

  target_group_arn = aws_lb_target_group.lb_tg_https.arn
  target_id        = "${each.value}"
  port             = aws_lb_listener.lb_listener_https.port
}
