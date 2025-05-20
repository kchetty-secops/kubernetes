resource "aws_secretsmanager_secret" "datadog_api_key" {
  name = "datadog/api-key"
}

resource "aws_secretsmanager_secret_version" "datadog_api_key_version" {
  secret_id     = aws_secretsmanager_secret.datadog_api_key.id
  secret_string = "DUMMY_VALUE" # <-- safe placeholder, will not overwrite real secret

  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}
