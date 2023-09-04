variable "random_number" {
    type        = number
    description = "A random number to identify resources"
    default     = 0
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "Resource group location"
}
