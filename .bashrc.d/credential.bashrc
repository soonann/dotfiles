# aws credentials
if [ -f /home/ann/scripts/set_aws_credentials.sh ]; then
    . /home/ann/scripts/set_aws_credentials.sh
fi

# mongo credentials
if [ -f /home/ann/scripts/set_mongo_credentials.sh ]; then
    . /home/ann/scripts/set_mongo_credentials.sh 
fi
