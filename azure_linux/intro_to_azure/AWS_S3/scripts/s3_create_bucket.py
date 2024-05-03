import boto3

# Create an S3 client
s3 = boto3.client('s3')

# Specify the bucket name
bucket_name = 'tech258-joshual-test-boto3'

# Specify the region where the bucket will be located
region = 'eu-west-1'

# Create the bucket with the specified region
s3.create_bucket(Bucket=bucket_name, CreateBucketConfiguration={'LocationConstraint': region})
