OCI deployment over OCI OKE  using blue green deployment strategies.
=======

- create a terraform.tfvars file based on the sample below.

```
# Authentication
tenancy_ocid         = "<OCID Of OCI Tenancy>"
user_ocid            = "<OCID OF AN OCI USER >"
fingerprint          = "OCI FINGER PRINT"
private_key_path     = "PRIVATE KEY PATH "

# Region
region = "OCI REGION "

# Compartment
compartment_ocid = "<OCI OF OCI COMPARTMENT>" 

# OCI  
oci_username         = "<OCI TENANCY/USERNAME or FEDERATED USER INFORMATION>"
oci_user_authtoken     = "USER SECRET KEY"

# Set a value which will be prefixed to the resource names.
app_name = "mycanary"

```

Special instructions 

```
- In order to install Nginx we are using terraform local executor with kubectl and oci . So for manual run you must have kubectl (installed and available) and oci cli (with pre -authenticated)
- In case its not available , You can comment the all the lines including the line `resource "null_resource" "oke_nginix_setup" {` till the end and later install Nginx and namespaces manually (Refer the detailed instruction at the end)
```

Terraform instructions (for manual run)

```
$ terraform init
$ terraform plan -out plan.out
$ terraform apply
$ terraform destroy (Ensure to delete the loadbalancer created by kubernetes before doing terraform destroy)
```

How to Test and do a rollback.
----

- OCI Console > Developer Services > DevOps>Project>Project Name>Build pipeline  do click Start manual run.
- Wait until all the build stages completed.
- Switch to the deployment pipeline and click on the deployment which is in progress.
- The pipeline will be pending for Approval stage.
- Validate the first deployment at this stage. You should see a valid deployments at namespace nsgreen ,via cloud shell (prior to it ensure to set the access to OKE cluster enabled).

```
for i in nsgreen nsblue ; do echo "-- NS:$i --";kubectl get po,ing -n $i; done

```

- Click on the 3 dots and validate the Control:Approval stage.
- Wait for all the steps to complete.
- Validate the deployment using the Ingress Address via CURL or BROWSER.
- Edit the source code - main.py and change the version to 0.1 and run the build pipeline again to test a new deployment scenario.
- Go back to build pipeline and do click Start manual run.
- Wait untill all the build stages completed.
- Switch to the deployment pipeline and click on the deployment which is in progress.
- The pipeline will be pending for Approval stage.
- Validate the first deployment at this stage. You should see a valid deployments at namespace nsblue too.

```
for i in nsgreen nsblue ; do echo "-- NS:$i --";kubectl get po,ing -n $i; done

```

- You can continue other re-run from build pipeline and validate the switch between environment.
- Let us now try a Manul rollback.
- Use the 3 dots at the stage Traffic Shift stage and select Manual Rollback.
- Detailed instruction is here -https://github.com/oracle-devrel/oci-devops-examples/tree/main/oci-deployment-examples/oci-devops-deploy-with-blue-green-model
