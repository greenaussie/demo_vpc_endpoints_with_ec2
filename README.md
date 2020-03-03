# VPC Endpoints with EC2

A quick work through using VPCs without internet connectivity. We aim to be able to connect to the EC2 instance using AWS Systems Manager's Session Manager service. It is unlikely this would be sufficent for a real service, and note that it is not possible to access (for instance) updates for the instance.

We are forced to use the VPC's Amazon DNS resolver because we want to use the public service endpoint names.

To resolve the addresses of a directory, we need to configure the Route 53 service to forward some requests to specific resolvers.

After deleting a VPC endpoint it can be a while before it is possible to create a new endpoint.

## Usage

Deploy script uses Docker.

```bash
bin/deploy.sh
```

## References

[How do I create VPC endpoints so that I can use Systems Manager to manage private EC2 instances without internet access?](https://aws.amazon.com/premiumsupport/knowledge-center/ec2-systems-manager-vpc-endpoints/)
[Forwarding Outbound DNS Queries to Your Network](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resolver-forwarding-outbound-queries.html)