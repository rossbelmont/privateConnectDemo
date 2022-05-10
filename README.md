# Private Connect Demo Assets
Configuration scripts and other artifacts used to build a demo of Private Connect

### Overview and Configuration
This repo captures the essential assets needed to configure a demo of Private Connect. It requires an AWS account and a Salesforce org with Private Connect licenses.

The items in the `unpackaged` directory can be deployed to a Salesforce org to speed up configuration of a demo that makes a callout to a Lambda on AWS over Private Connect. The callout is in an Apex class wrapped in an `InvocableMethod` so it can be called via Flow. The Flow is designed to update the Rating field on a Lead after calling out to a fictious lead scoring service on AWS. (Place the Assign Rating action on the Lead record page to round out the demo.)

The Apex makes an actual callout to AWS, but instead of referencing a sophisticated lead scoring algorithm, it calls a Lambda that returns a random number. (The random number is used along with Flow logic to persist the Rating value.) The `lambda-inbound.yaml` file in the `cloudformation` directory is a CloudFormation template that configures the AWS resources needed to route an HTTP call over Private Connect to the Lambda. You will notice it requires four parameters:

- IAM Role from Salesforce: This is a string in the format `arn:aws:iam::123456789:role/us-west-2-private-connect` and can be found on the Private Connect page under Setup in the Salesforce org containing the required licenses. It's used to configure PrivateLink to trust traffic from Salesforce.
- VPC ID: This is a string in the format `vpc-32b66353`, identifying the virtual private cloud containing the resources accessed via Private Connect.
- Subnet 1: This is a string in the format `subnet-cba52395`, and is used to define the routing for the VPC.
- Subnet 2: This is a string in the format `subnet-8cf447a9`, and is also used to define the routing for the VPC. (Redundancy is required.)