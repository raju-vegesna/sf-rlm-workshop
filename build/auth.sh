# Get the private key from the environment variable
echo "Setting up ORG Connection..."
mkdir keys
echo $SFDC_SERVER_KEY | base64 -d > keys/server.key

# Authenticate to salesforce
echo "Authenticating..."
sfdx force:auth:jwt:grant --clientid $SFDC_CLIENTID --jwtkeyfile keys/server.key --username $SFDC_USER --instanceurl $SFDC_INSTANCE_URL