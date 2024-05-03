import boto3

# Create an S3 client
s3 = boto3.client('s3')

# Specify the bucket name
bucket_name = 'tech258-joshual-test-boto3'

# Delete the bucket
s3.delete_bucket(Bucket=bucket_name)