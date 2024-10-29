# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "shared_credentials_files" {
    description = "Path to the shared credentials file"
    type        = list(string)
    default     = ["~/.aws/credentials"]
}

variable "profile" {
    description = "AWS profile"
    type        = string
    default     = "pygio_learning"
}
