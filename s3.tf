resource "aws_s3_bucket" "this" {
  bucket = "#alterar-nome"
}


resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

terraform {
  backend "s3" {
    bucket         = "#alterar-nome"
    key            = "autoscaling/versoes/terraform.tfstate"
    region         = "us-east-1"                      
    encrypt        = true
  }
}
