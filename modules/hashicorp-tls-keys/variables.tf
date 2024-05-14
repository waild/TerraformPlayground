variable "algorithm" {
  type        = string
  default     = "ECDSA"
  description = "Crypto algorithm (e.g. RSA, ECDSA)"
}

variable "ecdsa_curve" {
  type        = string
  default     = "P256"
  description = "Eliptic curve (e.g. P256, P384, P521)"
}
