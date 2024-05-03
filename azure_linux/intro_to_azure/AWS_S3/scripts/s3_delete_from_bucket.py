import boto3

# Create an S3 client
s3 = boto3.client('s3')

# Specify the file to delete and the bucket name
file_name = 'test.txt'
bucket_name = 'tech258-joshual-test-boto3'

# Delete the file
s3.delete_object(Bucket=bucket_name, Key=file_name)
