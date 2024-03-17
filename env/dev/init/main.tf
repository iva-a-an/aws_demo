
#generate random suffix
resource "random_pet" "suffix" {}

resource "aws_s3_bucket" "tf_demo" {
  bucket = "tf-demo-${random_pet.suffix.id}"
  tags = var.tags
}


## TODO: Create Access Policy for the bucket `