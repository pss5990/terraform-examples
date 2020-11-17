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
1. simple-tf-config - Simple tf configuration with provider initialization (using file function for SA key lookup).
2. tf-config-var-func - An example showing the usage of variables, count, count.index, count with conditional assignment, locals, string join function and data sources.
3. 


