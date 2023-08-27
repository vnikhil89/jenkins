provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}  


data "oci_core_images" "compute_images"{
    compartment_id = var.compartment_ocid
    operating_system = var.image_operating_system
    operating_system_version = var.image_operating_system_version
    shape = var.instance_shape
}

data "oci_core_subnets" "public_subnet" {
  compartment_id = var.compartment_ocid
  display_name = var.private_subnet_dns_label
}

resource "oci_core_instance" "web-01" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = var.vmnames
  shape               = var.instance_shape

  create_vnic_details {
    #subnet_id = var.net_id
    subnet_id = data.oci_core_subnets.public_subnet.subnets[0].id
    #display_name = "Web-Server-01"
    display_name = var.vmnames
  }
  source_details {
    source_type             = "image"
    source_id               = lookup(data.oci_core_images.compute_images.images[0], "id")
    boot_volume_size_in_gbs = "50"
  }
   metadata = {
     ssh_authorized_keys = var.ssh_public_key
   }
  connection {
    type = "ssh"
	    user = "opc"
      private_key = "${file("/Users/niks/.ssh/id_rsa")}"
	    host = oci_core_instance.web-01.public_ip
  }
  provisioner "file" {
    source = "jenkins.sh"
    destination = "/tmp/jenkins.sh"
  }
  provisioner "remote-exec"{
    inline=[
      "chmod +x /tmp/jenkins.sh",
      "sudo /tmp/jenkins.sh"
      ]
  }
}