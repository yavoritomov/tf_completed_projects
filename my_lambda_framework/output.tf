output "lambda_arn" {
  value = tomap({
    for arn, lamb in aws_lambda_function.terraform_lambda_func : arn => lamb.arn
  })
}

output "eventbridge_arn" {
  value = tomap({
    for arn, eventbridge in aws_cloudwatch_event_rule.trigger : arn => eventbridge.arn
  })
}

output "function_endpoint" {
  value = tomap({
    for function_url, function_name in aws_lambda_function_url.url_trigger : function_url => function_name.function_url
  })
}

output "function_endpoint_test" {
  value = values(aws_lambda_function_url.url_trigger)[*].function_url
}
