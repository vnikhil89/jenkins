variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "vcn_dns_label" {}
variable "vcn_cidr" {}
variable "public_cidr" {}
variable "private_cidr" {}
variable "public_subnet_dns_label" {}
variable "private_subnet_dns_label" {}
variable "image_operating_system" {}
variable "image_operating_system_version" {}
variable "instance_shape" {}
variable "vmnames" {
    type        = list(string)
}
variable "ssh_public_key" {}