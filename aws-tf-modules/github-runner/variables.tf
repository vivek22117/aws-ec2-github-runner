############################
# Global variables         #
############################
variable "default_region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "github_runner_name" {
  type = string
  description = "Name of EC2 acting as github runner"
}

variable "environment" {
  type = string
  description = "Environment to launch runner"
}
