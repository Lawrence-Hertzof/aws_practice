resource "aws_sqs_queue" "terraform_queue" {
  name                      = var.queue_name
  delay_seconds             = 90
  max_message_size          = 4096
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Environment = var.environment  
    Name        = var.queue_name
    }
}