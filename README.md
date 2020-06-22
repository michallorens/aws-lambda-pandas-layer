# Usage
```hcl-terraform
module aws_lambda_pandas_layer {
  source = "github.com/michallorens/aws-lambda-pandas-layer"

  pandas_version = "1.0.5"
  python_version = "3.8"
}
```