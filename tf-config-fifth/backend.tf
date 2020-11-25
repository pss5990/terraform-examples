terraform {
  backend "gcs" {
// Functions or variables are not allowed here so must be hardcoded
    credentials = "../../keys/loans-project-editor-sa.json"
    bucket     = "tf-practice-fifth-ex"
    prefix     = "dev"
  }
}
