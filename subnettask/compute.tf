# ami-01e82af4e524a0aa3  -> we need to go aws console to get the ami.
# us-west-2 -> ami change with the region, choose the correct region
# aws ec2 describe-images --image-ids ami-01e82af4e524a0aa3 --region us-west-2  -> command to get the ami imformation
# "OwnerId": "137112412989"
# "Name": "al2023-ami-2023.3.20240205.2-kernel-6.1-x86_64"
# terraform state show data.aws_ami.server_ami -> after apply we can check ami from the state file

data "aws_ami" "server_ami" {
    most_recent = true
    owners = ["137112412989"]
    filter {
        name = "name"
        values = [ "al2023-ami-2023.3.20240205.2-kernel-6.1-x86_64" ]
    }
}
