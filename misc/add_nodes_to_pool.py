import oci

config = oci.config.from_file("~/.oci/config","DEFAULT")
identity = oci.identity.IdentityClient(config)
user = identity.get_user(config["user"]).data
print(user)


management_client = oci.core.ComputeManagementClient(config)
update = oci.core.models.UpdateInstancePoolDetails(size=2)

management_client.update_instance_pool("ocid1.instancepool.oc1.eu-frankfurt-1.aaaaaaaazmnyykpa5aysclbwc6x5imghmtjirmh2xikjgmn2vn3ywvyf6dwq", update)
