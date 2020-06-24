# Usage
```hcl-terraform
module aws_lambda_python_layer {
  source = "github.com/michallorens/aws-lambda-pandas-layer"

  python_version = "python3.8"
  bucket = "your-bucket"
  libraries = [
    "pandas==1.0.5",
    "strsim"
  ]
}
```
