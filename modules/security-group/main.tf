resource "aws_security_group" "this" {
  name        = "${var.prefix_name}-${var.environment_name}-sg"
  description = "Security group for ${var.prefix_name}-${var.environment_name}"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prefix_name}-${var.environment_name}-sg"
    Environment = var.environment_name
  }
}
