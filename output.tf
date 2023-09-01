output "Instance_Public_IP"{
  value = [oci_core_instance.web-01.private_ip]
}
