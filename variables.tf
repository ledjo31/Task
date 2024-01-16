variable "private_key_aws_path" {
    type = string
    default = "/home/ledjo/Documents/Task/ledjo.pem"
}

variable "instance_count" {
  description = "Number of Polkadot instances to create"
  type        = number
  default     = 2
}