# Configure the Oracle Cloud Infrastructure provider with an API Key
provider "oci" {
  tenancy_ocid = ""
  user_ocid = ""
  fingerprint = ""
  private_key_path = ""
  region = "eu-frankfurt-1"
  version = "3.9"
}

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaa3eiex6fbfj626uwhs3dg24oygknrhhgfj4khqearluf4i74zdt2a"
}

# Output the result
output "show-ads" {
  value = "${data.oci_identity_availability_domains.ads.availability_domains}"
}

# resource "oci_core_instance" "CodrinInstance" {
#   count = "1"
#   compartment_id = "ocid1.tenancy.oc1..aaaaaaaa3eiex6fbfj626uwhs3dg24oygknrhhgfj4khqearluf4i74zdt2a"
#   availability_domain = "GFrv:EU-FRANKFURT-1-AD-3"
#   shape = "VM.Standard1.1"
#   subnet_id = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaantormtbnt3abxrlhz7dulty3hgwmcvnb5b322ty5ccjvggflwyqq"
#   image = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa6xa7jqc6nzpliqzj2jwk4d5rwcbwugdji3vr3jumuq2c7q32f2sa"
# }
data "oci_core_instance_configuration" "CodrinConfig" {
	compartment_id = "ocid1.tenancy.oc1..aaaaaaaa3eiex6fbfj626uwhs3dg24oygknrhhgfj4khqearluf4i74zdt2a"
}
