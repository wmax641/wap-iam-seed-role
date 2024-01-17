# wap-iam-seed-role
Creates the initial OIDC trust relationship with github
Creates the initial IAM role for assumption by github actions to deploy other WAP IAM resources
Creates initial permission boundaries for WAP

This should be manually run in each account to initialise an `IAMSeedRole` and form an OIDC Identity Provider with Github

`var.thumbprint_list_github` may need to be updated from time to time

## Usage
Needs to be manually deployed with AWS credentials

```bash
make init
make plan
make apply
```
