# VPC Endpoints with EC2

A quick work through using VPCs without internet connectivity. We aim to be able to connect to the EC2 instance using AWS Systems Manager's Session Manager service. It is unlikely this would be sufficent for a real service, and note that it is not possible to access (for instance) updates for the instance.

## Usage

Deploy script uses Docker.

```bash
bin/deploy.sh
```
