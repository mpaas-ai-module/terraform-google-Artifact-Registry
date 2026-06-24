variable "project_id" {
  type        = string
  description = "Name of the project"
}
variable "location" {
  type        = string
  description = "Name of the location this repository is located in."
}
variable "no_of_repos" {
  type        = number
  description = "Number of the repositories  in the artifact registry"
}
variable "name_of_repos" {
  type        = list(string)
  description = "Name of the repository id in the artifact registry"
}
variable "description" {
  type        = list(string)
  description = "The user-provided description of the repository."
  default     = ["Default description"]
}
variable "kms_key_name" {
  type        = string
  description = "Name of the kms key artifact_registry_repository"
}
variable "format" {
  type        = string
  description = "The format of packages that are stored in the repository.eg Docker Image Manifest V2, Schema 1, Docker Image Manifest V2, Schema 2,Open Container Initiative (OCI)"
}
variable "mode" {
  type        = string
  description = "The mode of the repository.Possible values are: STANDARD_REPOSITORY, VIRTUAL_REPOSITORY, REMOTE_REPOSITORY."
  default     = "STANDARD_REPOSITORY"
}




