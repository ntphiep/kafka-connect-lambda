provider "aws" {
  #  access_key                  = "test"
  region = "us-east-1"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda_kafka"

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

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
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

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_lambda_function" "kafka_sink_lambda" {
  function_name    = "kafka_sink_lambda"
  filename         = "../app.zip"
  handler          = "app.lambda_handler"
  role             = aws_iam_role.iam_for_lambda.arn
  source_code_hash = filebase64sha256("../app.zip")
  runtime          = "python3.8"
  timeout          = 5
  memory_size      = 128

  tags = {
    Environment = "${var.environment_name}"
  }
}


resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/kafka_sink_lambda"
  retention_in_days = 1
}


