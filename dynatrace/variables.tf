variable "k8s-config_path" {
  type = string
  default = "~/.kube/config"
}

variable "dynatrace-operator-version" {
  type = string
  default = "1.2.0"
}

variable "dynatrace-deployment-mode" {
  type = string
  default = "applicationMonitoring"
  validation {
    condition = contains(["applicationMonitoring", "classicFullStack", "cloudNativeFullStack", "hostMonitoring"], var.dynatrace-deployment-mode)
    error_message = "Invalid value for dynatrace-deployment-mode. Please choose one of the allowed options."
  }
}
 
locals {
  dynatrace-operator-csi-driver = var.dynatrace-deployment-mode == "applicationMonitoring" || var.dynatrace-deployment-mode == "cloudNativeFullStack"
}

variable "dynatrace-api-url" {
  type = string #https://ENVIRONMENTID.live.dynatrace.com/api
}

variable "dynatrace-apiToken" {
  type = string 
}

variable "dynatrace-dataIngestToken" {
  type = string
}

variable "cluster-name" {
  type = string
}