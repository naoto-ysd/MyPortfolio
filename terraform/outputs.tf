output "webhook_url" {
  description = "Webhook URL for microCMS"
  value       = "${aws_api_gateway_rest_api.webhook.execution_arn}/prod/webhook"
}

output "api_gateway_url" {
  description = "API Gateway invoke URL"
  value       = "${aws_api_gateway_deployment.webhook.invoke_url}/webhook"
}

output "deploy_bucket_name" {
  description = "S3 bucket name for deployment"
  value       = aws_s3_bucket.deploy.bucket
}

output "deploy_bucket_website_url" {
  description = "S3 bucket website URL"
  value       = aws_s3_bucket.deploy.website_endpoint
}

output "artifacts_bucket_name" {
  description = "S3 bucket name for artifacts"
  value       = aws_s3_bucket.artifacts.bucket
}

output "codepipeline_name" {
  description = "CodePipeline name"
  value       = aws_codepipeline.main.name
}

output "codebuild_project_name" {
  description = "CodeBuild project name"
  value       = aws_codebuild_project.main.name
} 
