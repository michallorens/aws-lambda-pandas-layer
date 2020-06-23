# Usage
```hcl-terraform
module aws_lambda_python_layer {
  source = "github.com/michallorens/aws-lambda-pandas-layer"

  bucket = "your-bucket"
  libraries = [
    "pandas==1.0.5",
    "strsim"
  ]
}
```