
#s3-backend for terraform statefile locking via DynamoDB
terraform {
  backend "s3" {
    bucket         = "terraform-tfstate-alarm"
    key            = "devops/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "s3-state-lock"
  }
}

# Make a topic

resource "aws_sns_topic" "alarm" {
  name            = lookup(var.sns_topic,terraform.workspace)
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF

  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.alarms_email}"
  }
}