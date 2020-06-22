# Usage
```hcl-terraform
module aws_lambda_python_layer {
  source = "github.com/michallorens/aws-lambda-pandas-layer"

  libraries = [
    "pandas==1.0.5",
    "strsim"
  ]
}
```