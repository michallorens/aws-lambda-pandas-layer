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