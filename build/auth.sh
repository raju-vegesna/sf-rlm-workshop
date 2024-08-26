# Get the private key from the environment variable
echo "Setting up ORG Connection..."
mkdir keys
echo $SFDC_SERVER_KEY | base64 -d > keys/server.key

# Authenticate to salesforce
echo "Authenticating with ... " $SFDC_USER
# sfdx force:auth:jwt:grant --client-id $SFDC_CLIENTID --jwtkey-file keys/server.key --username $SFDC_USER --instance-url $SFDC_INSTANCE_URL
sf org login jwt --client-id=$SFDC_CLIENTID --jwt-key-file=keys/server.key --username=$SFDC_USER --instance-url=$SFDC_INSTANCE_URL