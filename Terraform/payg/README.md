# FortiWeb

This module deploys a [FortiWeb Web Application Firewall (PAYG)](https://console.cloud.google.com/marketplace/product/fortigcp-project-001/fortiweb-web-application-firewall-payg) from Marketplace.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| boot\_disk\_size | The boot disk size for FortiWeb in GBs | `string` | `"31"` | no |
| boot\_disk\_type | The boot disk type for the FortiWeb. | `string` | `"pd-ssd"` | no |
| enable\_tcp\_8443 | Enable network traffic over tcp port 8443 for FortiWeb | `bool` | `false` | no |
| enable\_tcp\_8080 | Enable network traffic over tcp port 8080 for FortiWeb | `bool` | `false` | no |
| enable\_tcp\_443 | Enable network traffic over tcp port 443 for FortiWeb | `bool` | `false` | no |
| enable\_tcp\_80 | Enable network traffic over tcp port 80 for FortiWeb | `bool` | `false` | no |
| enable\_tcp\_22 | Enable network traffic over tcp port 22 for FortiWeb | `bool` | `false` | no |
| external\_ips | The external IPs assigned to the VM for public access. | `list(string)` | <pre>[<br>  "EPHEMERAL"<br>]</pre> | no |
| goog\_cm\_deployment\_name | The name of the deployment and VM instance. | `string` | n/a | yes |
| machine\_type | The machine type to create, e.g. e2-small | `string` | `"n2-standard-4"` | no |
| networks | The network name to attach the VM instance. | `list(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| project\_id | The ID of the project in which to provision resources. | `string` | n/a | yes |
| source\_image | The image name for the disk for the VM instance. | `string` | `"projects/fortigcp-project-001/global/images/fwb-763-payg-03102025-001-w-license"` | no |
| sub\_networks | The sub network name to attach the VM instance. | `list(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| tcp\_8443\_ip\_source\_ranges | A comma separated string of source IP ranges for accessing the VM instance over tcp port 8443. | `string` | n/a | yes |
| tcp\_8080\_ip\_source\_ranges | A comma separated string of source IP ranges for accessing the VM instance over tcp port 8080. | `string` | n/a | yes |
| tcp\_443\_ip\_source\_ranges | A comma separated string of source IP ranges for accessing the VM instance over tcp port 443. | `string` | n/a | yes |
| tcp\_80\_ip\_source\_ranges | A comma separated string of source IP ranges for accessing the VM instance over tcp port 80. | `string` | n/a | yes |
| tcp\_22\_ip\_source\_ranges | A comma separated string of source IP ranges for accessing the VM instance over tcp port 22. | `string` | n/a | yes |
| zone | The zone for the solution to be deployed. | `string` | `"us-central1-b"` | no |

## Outputs

| Name | Description |
|------|-------------|
| admin\_user | Admin username for FortiWeb |
| admin\_password | Password for the admin user |
| has\_external\_ip | Flag to indicate if the FortiWeb machine has an external IP |
| instance\_machine\_type | Machine type for the FortiWeb compute instance |
| instance\_nat\_ip | Machine type for the FortiWeb compute instance |
| instance\_network | Machine type for the FortiWeb compute instance |
| instance\_self\_link | Self-link for the FortiWeb compute instance |
| instance\_zone | Zone for the FortiWeb compute instance |
