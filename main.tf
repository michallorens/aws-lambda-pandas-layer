locals {
  clean = "rm -rf ${path.module}/build/libs"
  build = "pip install --upgrade ${join(" ", var.libraries)} --target ${path.module}/build/libs/python/lib/python${data.external.python-version.result.version}/site-packages/."
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
  output_path = "${path.module}/build/aws-lambda-python-layer-${null_resource.default.id}.zip"
  source_dir  = "${path.module}/build/libs"
  type        = "zip"

  depends_on  = [null_resource.default]
}

data external python-version {
  program = ["bash", "${path.module}/python_version.sh"]
}

resource random_id default {
  byte_length = 8
}

resource aws_lambda_layer_version default {
  filename   = data.archive_file.default.output_path
  layer_name = "python-layer-${random_id.default.b64_url}"

  compatible_runtimes = [
    "python${data.external.python-version.result.version}"
  ]
}