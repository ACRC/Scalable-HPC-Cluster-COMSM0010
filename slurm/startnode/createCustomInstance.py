import oci
import base64
import sys
import os

def createInstance(instance_label):


	label_to_ip = {
	"compute001": "10.1.0.201",
	"compute002": "10.1.0.202",
	"compute003": "10.1.0.203",
	"compute004": "10.1.0.204",
	"compute005": "10.1.0.205",
	"compute006": "10.1.0.206",
	"compute007": "10.1.0.207",
	"compute008": "10.1.0.208",
	"compute009": "10.1.0.209",
	"compute010": "10.1.0.210",
	"compute011": "10.1.0.211",
	"compute012": "10.1.0.212",
	"compute013": "10.1.0.213",
	"compute014": "10.1.0.214",
	"compute015": "10.1.0.215",
	"compute016": "10.1.0.216",
	"compute017": "10.1.0.217",
	"compute018": "10.1.0.218",
	"compute019": "10.1.0.219",
	"compute020": "10.1.0.220",
	"highmem001": "10.1.0.221",
	"highmem002": "10.1.0.222",
	"highmem003": "10.1.0.223",
	"highmem004": "10.1.0.224",
	"highmem005": "10.1.0.225",
	"highcpu001": "10.1.0.226",
	"highcpu002": "10.1.0.227",
	"highcpu003": "10.1.0.228",
	"highcpu004": "10.1.0.229",
	"highcpu005": "10.1.0.230",
	}

	label_to_shape = {
	"compute": "VM.Standard1.1",
	"highmem": "VM.Standard2.1",
	"highcpu": "VM.Standard1.4"
	}

	ip = label_to_ip[instance_label]
	sh = label_to_shape[instance_label[:7]]

	with open("/usr/local/bin/init_script.sh") as f:
		content = f.readlines()

	content = "".join(content)
	encoding = base64.b64encode(content)

	config = oci.config.from_file("/home/slurm/opc/config","DEFAULT")
	identity = oci.identity.IdentityClient(config)
	user = identity.get_user(config["user"]).data

	management_client = oci.core.ComputeManagementClient(config)

	compute_client = oci.core.compute_client.ComputeClient(config)

	vnic_details = oci.core.models.CreateVnicDetails(private_ip=ip, assign_public_ip=True, subnet_id = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaantormtbnt3abxrlhz7dulty3hgwmcvnb5b322ty5ccjvggflwyqq")

	update = oci.core.models.LaunchInstanceDetails(metadata={"user_data":encoding, "ssh_authorized_keys":"key"}, create_vnic_details=vnic_details, display_name=instance_label, hostname_label=instance_label, availability_domain="GFrv:EU-FRANKFURT-1-AD-3", compartment_id="ocid1.compartment.oc1..aaaaaaaa6u2o5avo46qt6oa2giscsuwwe2xa7k3qmjcwmtjrsc2ldkm2u6vq", shape = sh, subnet_id = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaantormtbnt3abxrlhz7dulty3hgwmcvnb5b322ty5ccjvggflwyqq", image_id = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaasx2dzqi4iwxjg6zenlcsjmb4ziyhbpknp33tixdbdud7xqefq4pa")

	instance = compute_client.launch_instance(update)
	os.environ['instance_id'] = instance.data.id
	print(os.environ['instance_id'])


if __name__== "__main__":
	instance_label= sys.argv[1]
	createInstance(instance_label)
