# Azure Fast Data 

## Project Objective

"Provide an infrastructure capable of handling Batch and Streaming data (lambda architecture) in the Microsoft Azure environment"

## Table of Contents

- [Overview](#project-objective)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Installation

After cloning the repository, install Terraform and the Azure CLI. 

Through the Azure CLI, pass the AZ login command to log in to your Azure account (to create the resources, you will need to have an Azure subscription created).

Before running the terraform apply command, check the variable.tf file and set the location variable to the location you want to use. 

In the terminal run the command, access the path azure_fast_data/infrastructure and run the command terraform Plan, to view the components that will be created, then if you agree, run the command terraform apply.  

After testing, don't forget to run the terraform destroy command, to remove the resources and not create unnecessary costs in the Azure environment.


### Infrastructure Images

[//]: https://github.com/pradovalmur/azure_fast_data/blob/main/infrastructure/Untitled%20Diagram.drawio


## Contributing

[//]: # "Explain how others can contribute to your project, such as guidelines for reporting issues, submitting pull requests, or participating in discussions."

## License

[//]: # "Specify the license under which your project is distributed."

