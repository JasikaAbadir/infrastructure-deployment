# Infrastructure deployment exercise

Using Terraform, automate the build of the following application in AWS. For the purposes of this challenge, use any Linux based AMI id for the two EC2 instances and simply show how they would be provisioned with the connection details for the RDS cluster.

![diagram](./images/diagram.png)

There are a lot of additional resources to create even in this simple setup, you can use the code we have made available that will create some structure and deploy the networking environment to make it possible to plan/apply the full deployment. Feel free to use and/or modify as much or as little of it as you like.

Document any assumptions or additions you make in the README for the code repository. You may also want to consider and make some notes on:

How would a future application obtain the load balancer’s DNS name if it wanted to use this service?

What aspects need to be considered to make the code work in a CD pipeline (how does it successfully and safely get into production)?

# Additions

## Bootstrap folder
This is the create the initial bucket for a remote backend.

## Challenge folder
This is where the main resources sit. A summary/ high level overview of the additions made include an autoscaling group provisioning a min/max 2 servers. A loadbalancer that is able to access the servers. The servers are able to access the RDS. Secrets for RDS are managed by AWS secrets manager. 

I installed apache to test the connection between load balancer and server, click [this link](cint-code-challenge-alb-1652398342.us-east-1.elb.amazonaws.com) to have a look!