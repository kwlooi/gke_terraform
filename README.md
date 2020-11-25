provider.tf:

Note: replace <YOUR_PROJECT_ID> with the project id from the output above, or copy it from "GCP Project ID" on the left side of this page.

In terraform, functionality is added via providers, and for Google Cloud, that provider is appropriately named "google". Google Cloud also provides a "google-beta" provider for up and coming features, which we will also need in this lab.

Terraform does not care what the names of the files are, as long as they end in .tf. The name here, provider.tf, is a convention where terraform configuration is put in separate files by "blast radius". This provider.tf:

    Declares our use of the "google" provider
    Sets our project as the (default) project to deploy resources into.
    Defines the (default) region for resources to run in


gke.tf:
This code:

    Creates a GKE Cluster with 3 Nodes
    Specifies the cluster should be on the "default" network
    Should use a VPC (and how) via the ip_allocation_policy block
    Specifies the worker node VM types as "n1-standard-2"
    Adds Cloud Run and Istio to the cluster
    Customizes the cloud-run generated domain to use xip.io


registry.tf:
establish and configure our container registry

custom-domain.sh:
This script modifies how Cloud Run for Anthos generates the URL for the deployed application. By default, it will use example.com, which isn't valid, so here we configure it to use xip.io instead. As complicated as this script might look, that is a big part of the value of automation → it's written down, so that it can be learned from.


terraform init
terraform plan
terraform apply

terraform destroy
