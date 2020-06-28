locals {
  docker_image = "docker.pkg.github.com/michallorens/aws-lambda-python-layer/${var.python_version}:latest"
}

data external pip-install {
  program = concat(["bash", "${path.module}/run_docker.sh", local.docker_image], var.libraries)
}

resource random_id hash {
  byte_length = 16

  keepers = {
    libraries = join(", ", sort(var.libraries))
  }
}

resource aws_s3_bucket_object default {
  bucket = var.bucket
  source = data.external.pip-install.result.path
  key    = "python-layer-${random_id.hash.b64_url}.zip"
  tags   = var.tags
}

resource aws_lambda_layer_version default {
  s3_bucket  = var.bucket
  s3_key     = aws_s3_bucket_object.default.key
  layer_name = "python-layer-${random_id.hash.b64_url}"

  compatible_runtimes = [
    var.python_version
  ]
}