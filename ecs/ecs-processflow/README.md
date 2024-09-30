## How to deploy Processflo backend

### Prequisites
1. Install Terraform -> [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
2. Install AWS CLI v2 -> [AWS_CLI_V2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) 
3. Setup Access/Secret keys in ~/.aws/credentials

### Deploy Steps
1. Init terraform with it's modules inside
```bash
    terraform init
```
terraform import module.route53.aws_route53_record.this_NS_record Z0516356YJK273XBOBXI_learning-aws-terraform.com._NS
terraformer import aws --resources=route53 --connect=true --regions=eu-west-2 --profile=default



