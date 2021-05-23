<img src="https://raw.githubusercontent.com/dentsuadmin/assets/master/terraform-logo-small.png" width="80" height="80" align="right" />
<img src="https://avatars3.githubusercontent.com/u/13183983?s=200&v=4" width="80" height="80" align="right" />
<img src="https://helm.sh/assets/images/helm-logo.svg" width="80" height="80" align="right" />

# Cert-manager-target Terraform module

## Overview

This module is similar to the original helm-cert-manager-tf12 module however it is deployed at <br>
Target level and is intended for use with the new "next generation" IAZ model. Typically this is<br> 
used with Istio and therefore by default the certificate object is created in the istio-system <br>
namespace for use by the envoy based istio-ingressgateway.
* Installs cert-manager into a Kubernetes cluster
* Create a clusterissuer for letsencypt production

## Pre-Requisites

* A Kubernetes cluster
* Jetstack helm repo added on your local machine: 

```
helm repo add jetstack https://charts.jetstack.io
```

## Usage

An example deployment:

```
"helm-cert-manager-tf12": {
      "az_email": "2469339d.aegisdentsunetwork.onmicrosoft.com@emea.teams.ms",
      "enabled": "1",
      "version": "DEVTOOL-870"
    }
```

## Usage
### NOTE: The module now handles the certificate creation; however here is how it can be done manually.
### Creating a default wildcard cert for istio-ingressgateway

If Istio has been deployed using the Dentsu DevOps k8s-istio-system-tf12 module, it will look for a certificate secret in the istio-system namepsace called `TBC`. 


## Known issues/limitations

* TBC

## Outputs

| Name | Description |
|------|-------------|
| complete | Indicates a module has run to completion |

