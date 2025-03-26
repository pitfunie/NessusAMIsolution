import boto3
import subprocess
import traceback

def lambda_handler(event, context):
    try:
        # Trigger Packer Build
        print("Running Packer build...")
        subprocess.run(["packer", "build", "packer/packer-template.json"], check=True)

        # Trigger Terraform Apply
        print("Running Terraform apply...")
        subprocess.run(["terraform", "apply", "-auto-approve"], check=True)

    except Exception as e:
        print(f"Error during execution: {e}")
        traceback.print_exc()
