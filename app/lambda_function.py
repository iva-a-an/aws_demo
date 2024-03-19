import requests
import boto3
from botocore.exceptions import ClientError


def lambda_handler(event, context):
    credentials = get_user_credentials()    
    return save_credentials(credentials)
    
    

def get_user_credentials():
    response = requests.get('https://randomuser.me/api')
    data = response.json()

    # The API returns a list of results. Get the first result.
    first_result = data['results'][0]

    # The 'login' object contains the 'username'.
    username = first_result['login']['username']
    password = first_result['login']['password']

    return username

def save_credentials(credentials):
    # Save the credentials to the AWS Secrets Manager
    secret_name = "demo_user"
    region_name = "us-east-1"

    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name,
    )

    try:
        response = client.create_secret(
            Name=secret_name,
            SecretString=credentials
        )
    except ClientError as e:
        if e.response['Error']['Code'] == 'ResourceExistsException':
            print(f"The secret {secret_name} already exists")
        else:        
            raise
    else:
        return response
