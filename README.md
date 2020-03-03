# VPC Endpoints with EC2

A quick work through using VPCs without internet connectivity.

We aim to be able to connect to the EC2 instance using AWS Systems Manager's Session Manager service. It is unlikely this would be sufficent for a real service, and note that it is not possible to access (for instance) updates for the instance. While this example is minimal, it could be extended if we wanted to connect to other nearby services, AWS services via other AWS VPC endpoints and more remote services via AWS PrivateLink

We are forced to use the VPC's Amazon DNS resolver because we want to use the public service endpoint names. To resolve an address which is not public, and handed by another DNS sytem (such as `mycompany.onprem`, or _split DNS_). We can AWS Route 53 service to forward some requests to specific resolvers.

## Usage

It is assumed there is an existing VPC which can reach the resolvers which will be used for forwarded requests (i.e. for requests which cannot be resolved by public DNS, such as `mycompany.onprem`, or _split DNS_ where a local DNS server overrides a public DNS record with a different response).

Create SSM parameters providing the template with VPC and two subnets which can both reach the DNS service to which you wish to forwards some DNS requests (the VPC and subnet IDs in the documentation are non-sensical - use your own!):

```bash
aws ssm put-parameter --name /demo/vpc_endpoints_with_ec2/resolver_subnet_a --value subnet-00000000 --type String
aws ssm put-parameter --name /demo/vpc_endpoints_with_ec2/resolver_subnet_b --value subnet-22222222 --type String
aws ssm put-parameter --name /demo/vpc_endpoints_with_ec2/resolver_vpc --value vpc-55555555 --type String

aws ssm get-parameter --name /demo/vpc_endpoints_with_ec2/resolver_subnet_a
aws ssm get-parameter --name /demo/vpc_endpoints_with_ec2/resolver_subnet_b
aws ssm get-parameter --name /demo/vpc_endpoints_with_ec2/resolver_vpc
```

Deploy script uses Docker, after you have exported to your environment, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_DEFAULT_REGION and perhaps AWS_SESSION_TOKEN (last on only if you have assumed a role).

```bash
bin/deploy.sh
```

After deleting a VPC endpoint it can be a while before it is possible to create a new endpoint due to caching of DNS records, so if you delete this stack, you may not be able to recreate it again for a few minutes.


## References

[How do I create VPC endpoints so that I can use Systems Manager to manage private EC2 instances without internet access?](https://aws.amazon.com/premiumsupport/knowledge-center/ec2-systems-manager-vpc-endpoints/)
[Forwarding Outbound DNS Queries to Your Network](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resolver-forwarding-outbound-queries.html)