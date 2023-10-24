terraform {
  cloud {
    organization = "findnull"

    workspaces {
      name = "Try_MailU"
    }
  }
}
terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.11.0"
    }
  }
}
