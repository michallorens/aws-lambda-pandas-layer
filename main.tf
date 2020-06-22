provider aws {}

locals {
  clean = "rm -rf build"
  build = "pip install --upgrade pandas==${var.pandas_version} --target build/python/lib/python${var.python_version}/site-packages/."
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
  output_path = "${path.module}/build/aws-lambda-pandas-layer-${null_resource.default.id}.zip"
  source_dir  = "${path.module}/build"
  type        = "zip"

  depends_on  = [null_resource.default]
}

resource aws_lambda_layer_version default {
  filename   = data.archive_file.default.output_path
  layer_name = "pandas"

  compatible_runtimes = [
    "python${var.python_version}"
  ]
}