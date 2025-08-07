terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-<your-unique-id>"
    key            = "env/dev/terraform.tfstate"  # Adjust based on environment
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}

