# シンプル版：Lambda不要の構成
# この構成では、microCMSの代わりにGitHubのwebhookを使用し、
# コンテンツ更新時にGitリポジトリにpushしてパイプラインを起動します

# Provider設定
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# S3バケット（アーティファクト保存用）
resource "aws_s3_bucket" "artifacts_simple" {
  bucket = "${var.project_name}-artifacts-simple-${random_id.bucket_suffix_simple.hex}"
}

resource "aws_s3_bucket_versioning" "artifacts_simple" {
  bucket = aws_s3_bucket.artifacts_simple.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "random_id" "bucket_suffix_simple" {
  byte_length = 8
}

# S3バケット（デプロイ先）
resource "aws_s3_bucket" "deploy_simple" {
  bucket = "${var.project_name}-deploy-simple-${random_id.deploy_bucket_suffix_simple.hex}"
}

resource "aws_s3_bucket_website_configuration" "deploy_simple" {
  bucket = aws_s3_bucket.deploy_simple.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "deploy_simple" {
  bucket = aws_s3_bucket.deploy_simple.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "deploy_simple" {
  bucket = aws_s3_bucket.deploy_simple.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.deploy_simple.arn}/*"
      },
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.deploy_simple]
}

resource "random_id" "deploy_bucket_suffix_simple" {
  byte_length = 8
}

# IAMロール（CodeBuild用）
resource "aws_iam_role" "codebuild_role_simple" {
  name = "${var.project_name}-codebuild-role-simple"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "codebuild_policy_simple" {
  name = "${var.project_name}-codebuild-policy-simple"
  role = aws_iam_role.codebuild_role_simple.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject"
        ]
        Resource = [
          "${aws_s3_bucket.artifacts_simple.arn}/*",
          "${aws_s3_bucket.deploy_simple.arn}/*"
        ]
      }
    ]
  })
}

# CodeBuildプロジェクト
resource "aws_codebuild_project" "main_simple" {
  name         = "${var.project_name}-build-simple"
  description  = "Simple build project for ${var.project_name}"
  service_role = aws_iam_role.codebuild_role_simple.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "DEPLOY_BUCKET"
      value = aws_s3_bucket.deploy_simple.bucket
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }
}

# IAMロール（CodePipeline用）
resource "aws_iam_role" "codepipeline_role_simple" {
  name = "${var.project_name}-codepipeline-role-simple"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "codepipeline_policy_simple" {
  name = "${var.project_name}-codepipeline-policy-simple"
  role = aws_iam_role.codepipeline_role_simple.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketVersioning",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject"
        ]
        Resource = [
          aws_s3_bucket.artifacts_simple.arn,
          "${aws_s3_bucket.artifacts_simple.arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild"
        ]
        Resource = aws_codebuild_project.main_simple.arn
      }
    ]
  })
}

# CodePipeline（GitHub webhookで自動起動）
resource "aws_codepipeline" "main_simple" {
  name     = "${var.project_name}-pipeline-simple"
  role_arn = aws_iam_role.codepipeline_role_simple.arn

  artifact_store {
    location = aws_s3_bucket.artifacts_simple.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner      = var.github_owner
        Repo       = var.github_repo
        Branch     = var.github_branch
        OAuthToken = var.github_token
        # PollForSourceChanges = false  # webhookを使用する場合
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.main_simple.name
      }
    }
  }
}

# GitHub webhook（オプション）
resource "aws_codepipeline_webhook" "github_webhook" {
  name            = "${var.project_name}-github-webhook"
  target_pipeline = aws_codepipeline.main_simple.name
  target_action   = "Source"

  authentication = "GITHUB_HMAC"

  authentication_configuration {
    secret_token = var.github_webhook_secret
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/${var.github_branch}"
  }
} 
