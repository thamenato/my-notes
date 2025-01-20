# Terraform

- Describe how you would import infrastructure made via GUI into Terraform.

- Describe how you store secrets using Terraform in AWS.

- Describe the purpose of modules and describe a novel way in which you have
  used them.

- Explain how you can use `count` and `for_each` to help create multiple
  resources.

- Terraform configuration to create a single EC2 instance on AWS.

```terraform
provider "aws" {
    region = "..."
}

resource "aws_instance" "example" {
    ami = "..."
    instance_type = "..."
    tags = {
        Name = "example"
    }
}
```
