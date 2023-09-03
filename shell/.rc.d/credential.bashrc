# aws credentials
if [ -f $HOME/scripts/set_aws_credentials.sh ]; then
    . $HOME/scripts/set_aws_credentials.sh
fi

# mongo credentials
if [ -f $HOME/scripts/set_mongo_credentials.sh ]; then
    . $HOME/scripts/set_mongo_credentials.sh 
fi
