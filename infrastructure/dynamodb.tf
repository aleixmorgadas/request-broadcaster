resource "aws_dynamodb_table" "registered_devices" {
  name = "registered-devices"
  billing_mode = "PROVISIONED"
  read_capacity = var.dynamo-db-read_capacity
  write_capacity = var.dynamo-db-write_capacity
  hash_key = "URL"

  server_side_encryption {
    enabled = true
    kms_key_arn = aws_kms_key.dynamodb_registered_devices_key.arn
  }

  attribute {
    name = "URL"
    type = "S"
  }

  tags = {
    Name = "registered-devices"
  }

  lifecycle {
    prevent_destroy = var.prevent_destroy_registered_devices_table
  }
}

resource "aws_kms_key" "dynamodb_registered_devices_key" {
  description = "encryption key for registered-devices DynamoDB Table"
  tags = {
    Name = "dynamodb-registered-devices-key"
  }
}

resource "aws_kms_alias" "dynamodb_registered_devices_key_alias" {
  target_key_id = aws_kms_key.dynamodb_registered_devices_key.id
  name = "alias/dynamodb-registered-devices-key"
}