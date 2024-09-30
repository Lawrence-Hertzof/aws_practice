resource "aws_ssm_parameter" "cellc_access_token" {
  name        = "cellc_access_token"
  description = "Access token for the CellC API"
  type        = "SecureString"
  value       = "some-secret-value"

  tags = {
    environment = "production"
  }
}


resource "aws_ssm_parameter" "telkom_access_token" {
  name        = "telkom_access_token"
  description = "Access token for the Teklom API"
  type        = "SecureString"
  value       = "some-secret-value"

  tags = {
    environment = "production"
  }
}


resource "aws_ssm_parameter" "processflow_db_password" {
  name        = "processflow_db_password"
  description = "Database password for the Processflo application"
  type        = "SecureString"
  value       = "some-secret-value"

  tags = {
    environment = "production"
  }
}


resource "aws_ssm_parameter" "processflow_db_username" {
  name        = "processflow_db_username"
  description = "Database username for the Processflo application"
  type        = "SecureString"
  value       = "some-secret-value"

  tags = {
    environment = "production"
  }
}


resource "aws_ssm_parameter" "email_sender_password" {
  name        = "email_sender_password"
  description = "Password for the email sender"
  type        = "SecureString"
  value       = "some-secret-value"

  tags = {
    environment = "production"
  }
}



resource "aws_ssm_parameter" "slack_webhook_url" {
  name        = "slack_webhook_url"
  description = "Password for the email sender"
  type        = "SecureString"
  value       = "some-secret-value"

  tags = {
    environment = "production"
  }
}
