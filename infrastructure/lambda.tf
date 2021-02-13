resource "aws_iam_role" "request_broadcaster_lambda_role" {
  name = "${local.lambda_name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "request_broadcaster_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = local.lambda_name
  role          = aws_iam_role.request_broadcaster_lambda_role.arn
  handler       = "index.handler"

  source_code_hash = filebase64sha256("lambda_function_payload.zip")

  runtime = "nodejs14.x"

  tags = merge(local.default_tags, map("Name", local.lambda_name))
}

# This is to optionally manage the CloudWatch Log Group for the Lambda Function.
# If skipping this resource configuration, also add "logs:CreateLogGroup" to the IAM policy below.
resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/${local.lambda_name}"
  retention_in_days = 7
}

resource "aws_iam_policy" "request_broadcaster_lambda_logging" {
  name        = "${local.lambda_name}-logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "request_broadcaster_lambda_logs" {
  role       = aws_iam_role.request_broadcaster_lambda_role.name
  policy_arn = aws_iam_policy.request_broadcaster_lambda_logging.arn
}