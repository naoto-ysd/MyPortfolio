# MyPortfolio CI/CD Infrastructure

このディレクトリには、microCMSからのwebhookを受け取ってNuxtアプリケーションをビルド・デプロイするためのAWSインフラストラクチャ定義が含まれています。

## アーキテクチャ

```
microCMS → API Gateway → Lambda → CodePipeline → CodeBuild → S3
```

## 含まれるリソース

- **API Gateway**: microCMSからのwebhookを受信
- **Lambda**: webhook処理とCodePipelineの起動
- **CodePipeline**: CI/CDパイプライン
- **CodeBuild**: Nuxtアプリケーションのビルド
- **S3 Bucket (artifacts)**: ビルドアーティファクトの保存
- **S3 Bucket (deploy)**: 静的サイトのホスティング
- **IAM Role**: 各サービス用の権限

## セットアップ手順

### 1. 前提条件

- AWS CLI が設定済み
- Terraform がインストール済み
- GitHubリポジトリが作成済み
- GitHub Personal Access Token が取得済み

### 2. 設定ファイルの作成

```bash
cp terraform.tfvars.example terraform.tfvars
```

`terraform.tfvars` を編集して、以下の値を設定してください：

```hcl
github_owner  = "your-github-username"
github_repo   = "MyPortfolio"
github_token  = "ghp_xxxxxxxxxxxxxxxxxxxx"
```

### 3. プロジェクトルートにbuildspec.ymlを配置

プロジェクトのルートディレクトリに `buildspec.yml` をコピーしてください：

```bash
cp terraform/buildspec.yml ../buildspec.yml
```

### 4. Terraformの実行

```bash
# 初期化
terraform init

# プランの確認
terraform plan

# リソースの作成
terraform apply
```

### 5. webhook URLの設定

Terraformの実行完了後、出力される `api_gateway_url` をmicroCMSのwebhook設定に追加してください。

## 使用方法

1. microCMSでコンテンツを更新
2. webhookが自動的にAPI Gatewayに送信
3. LambdaがCodePipelineを起動
4. CodeBuildがNuxtアプリケーションをビルド
5. ビルド結果がS3にデプロイ

## 出力値

- `api_gateway_url`: microCMSに設定するwebhook URL
- `deploy_bucket_website_url`: デプロイされたサイトのURL
- `codepipeline_name`: CodePipelineの名前
- `codebuild_project_name`: CodeBuildプロジェクトの名前

## トラブルシューティング

### GitHubトークンの権限

GitHubトークンには以下の権限が必要です：
- `repo` (リポジトリアクセス)
- `admin:repo_hook` (webhook管理)

### CodeBuildのビルドエラー

CloudWatch Logsでビルドログを確認してください：
```bash
aws logs describe-log-groups --log-group-name-prefix "/aws/codebuild/myportfolio-build"
```

## リソースの削除

```bash
terraform destroy
```

**注意**: S3バケットにファイルが残っている場合、手動で削除してからterraform destroyを実行してください。 