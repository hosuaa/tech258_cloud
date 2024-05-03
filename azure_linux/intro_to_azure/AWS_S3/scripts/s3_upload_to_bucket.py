import boto3

# Create an S3 client
s3 = boto3.client('s3')

# Specify the file to upload and the bucket name
file_name = 'test.txt'
bucket_name = 'tech258-joshual-test-boto3'

# Upload the file
s3.upload_file(file_name, bucket_name, file_name)
