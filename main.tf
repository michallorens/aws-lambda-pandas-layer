data external python-version {
  program = ["bash", "${path.module}/python_version.sh"]
}

data external pip-install {
  program = concat(["bash", "${path.module}/pip_install.sh", data.external.python-version.result.version], var.libraries)
}

data archive_file default {
  output_path = "${path.module}/build/aws-lambda-python-layer.zip"
  source_dir  = data.external.pip-install.result.path
  type        = "zip"
}

resource random_id default {
  byte_length = 8

  keepers = {
    libraries = join(", ", sort(var.libraries))
  }
}

resource aws_s3_bucket_object default {
  bucket = var.bucket
  source = data.archive_file.default.output_path
  key    = "python-layer-${random_id.default.b64_url}.zip"
}

resource aws_lambda_layer_version default {
  s3_bucket  = var.bucket
  s3_key     = aws_s3_bucket_object.default.key
  layer_name = "python-layer-${random_id.default.b64_url}"

  compatible_runtimes = [
    "python${data.external.python-version.result.version}"
  ]
}