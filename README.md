# terraform-examples
Examples of Terraform with GCP provider

Setup
1. Download terraform binary and add it to your PATH.
2. We need a GCP service account with Project editor role, create the SA and download the JSON key file for it.
3. Refer the file localtion in the credentials field under the provider block.
4. Change the GCP project id. (In the main.tf, project argument under the provider block for the first example otherwise in the terraform.tfvars file)
4. Do a "terraform init" in one of the example directories below.
5. Do a "terrafrom apply". You will see the resources that terraform will create. Types yes to continue creating the resources.


Examples
1. simple-tf-config -> Simple tf configuration with provider initialization (using file function for SA key lookup).
2. tf-config-var-func -> An example showcasing the usage of variables, count, count.index, count with conditional assignment, locals, string join function and data sources.
3. tf-config-third -> An example showcasing the usage of dynamic blocks, splat expressions and terraform provisioners.
		<br />terraform graph > base.dot
		<br />terraform graph | dot -Tsvg >  graph.svg
4. tf-config-fourth -> Example showcasing the usage of modules and workspaces.
		<br />terraform workspace new dev -> Creates a new dev workspace
		<br />terraform workspace show -> Shows the current workspace
		<br />terrform workspace list -> Lists all available workspaces
		<br />terrform workspace select dev -> Switch to dev as the current active workspace
5. tf-config-fifth -> So far in the above examples we did not provide a backend configuration so terraform used a local backend. This example covers how we can enable a standard remote backend in a GCS bucket. We will use git for terraform configuration but a remote GCS bucket for storing the terraform state files. This will enable collaboration and encryption at rest.

6. tf-config-sixth -> We have seen how we can maintain the terraform state files on a remote location to enable collaboration. In this example we will see how to use an enhanced terraform remote backend using terraform cloud. This will enable us to do remote operations. (Among the other features offered by terraform enterprise like sentinel, cost estimation etc).
	<br />a. Sign up for terraform cloud account
	<br />b. Connect terraform with Github as VCS with the credentials.
	<br />c. terraform.tfvars will not be picked up from the code, terraform cloud expects a file as \*.auto.tfvars.
	<br />d. Since we cannot upload the service account json key file to a public repository we have to make use of the terraform environment variables GOOGLE_CLOUD_KEYFILE_JSON and copy paste the content of the key file as value to this env. variable.

We can also link our local console to the terraform cloud , we wil need to follow these steps - 
	<br />a. Define the remote backend option in the terraform block.
	<br />b. Define the workspace, hostname and organization in \*.hcl file (Example backend.hcl in our case).
	<br />c. Run terraform login to login and connect terraform cloud to local console using token.
	<br />d. Run terraform init -backend-config=backend.hcl
	<br />e. Now that we are connected we can run terrafrom plan etc. commands from our termainal. However, we cannot run the terraform apply in this particular case because this workspace has a VCS connection and the workspaces with VCS connection are only allowed to be run for a VCS driven workflow to keep the VCS as the golden source.
	



