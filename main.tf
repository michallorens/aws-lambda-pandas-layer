locals {
  clean = "rm -rf ${path.module}/build/libs"
  build = "pip install --upgrade ${join(" ", var.libraries)} --target ${path.module}/build/libs/python/lib/python${data.external.default.result.version}/site-packages/."
}

resource null_resource default {
  triggers = {
    command = local.build
  }

  provisioner local-exec {
    command = "${local.clean} && ${local.build}"
  }
}

data archive_file default {
  output_path = "${path.module}/build/aws-lambda-python-layer.zip"
  source_dir  = "${path.module}/build/libs"
  type        = "zip"

  depends_on  = [null_resource.default]
}

resource aws_s3_bucket default {
  bucket = var.bucket
  acl    = "private"
}

resource aws_s3_bucket_object default {
  bucket = aws_s3_bucket.default.bucket
  source = data.archive_file.default.output_path
  key    = "python-layer-${random_id.default.b64_url}.zip"

  etag   = data.archive_file.default.output_base64sha256
}

data external default {
  program = ["bash", "${path.module}/python_version.sh"]
}

resource random_id default {
  byte_length = 8
}

resource aws_lambda_layer_version default {
  s3_bucket  = aws_s3_bucket.default.bucket
  s3_key     = aws_s3_bucket_object.default.key
  layer_name = "python-layer-${random_id.default.b64_url}"

  source_code_hash = data.archive_file.default.output_base64sha256

  compatible_runtimes = [
    "python${data.external.default.result.version}"
  ]
}