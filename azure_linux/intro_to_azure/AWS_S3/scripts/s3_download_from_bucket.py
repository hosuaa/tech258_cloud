import boto3

# Create an S3 client
s3 = boto3.client('s3')

# Specify the file to download and the bucket name
file_name = 'test.txt'
bucket_name = 'tech258-joshual-test-boto3'

# Download the file, save to downloaded_file.txt
s3.download_file(bucket_name, file_name, 'downloaded_file.txt')
