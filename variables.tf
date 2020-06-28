variable libraries {
  type        = list(string)
  description = "A list of python libraries to download."
}

variable bucket {
  type        = string
  description = "S3 bucket for storing zipped libraries."
}

variable python_version {
  type        = string
  description = "Python version to build lambda layer with."
  default     = "python3.7"
}

variable tags {
  type = object({
    environment = string
    application = string
    owner = string
  })
  description = "Tags for deployed resources"
  default = {
    environment = "development"
    application = "lambda-layer"
    owner       = "michal.lorens@datafeedwatch.com"
  }
}