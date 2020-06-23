variable libraries {
  type        = list(string)
  description = "A list of python libraries to download."
}

variable bucket {
  type        = string
  description = "S3 bucket for storing zipped libraries"
}