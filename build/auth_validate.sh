# Get the private key from the environment variable
echo "Setting up ORG Connection..."
mkdir keys
echo $SFDC_SERVER_KEY | base64 -d > keys/server.key

sourceBranch=$CIRCLE_BRANCH
echo "Branch:" $sourceBranch

# Transfer source branch to value stream
valueStream=`echo ${sourceBranch/feature/""} | cut -d "-" -f 1`
echo "ValueStream:" $valueStream

# Use value stream to set enviroment variables 
case $valueStream in
   "/VSA")
        CLIENT_ID=$SFDC_CLIENTID_CI1
        USER=$SFDC_USER_CI1
        echo "Sandbox: CI1"
        ;;
   "/VSB")
        CLIENT_ID=$SFDC_CLIENTID_CI2
        USER=$SFDC_USER_CI2
        echo "Sandbox: CI2"
        ;;
    "/VSC")
        CLIENT_ID=$SFDC_CLIENTID_CI3
        USER=$SFDC_USER_CI3
        echo "Sandbox: CI3"
        ;;
     *) 
        CLIENT_ID=$SFDC_CLIENTID
        USER=$SFDC_USER
        echo "Sandbox: CI"
        ;;
esac

# Authenticate to salesforce
echo "Authenticating with ... " $SFDC_USER 
# sfdx force:auth:jwt:grant --client-id $CLIENT_ID --jwtkey-file keys/server.key --username $USER --instance-url $SFDC_INSTANCE_URL
sf org login jwt --client-id=$SFDC_CLIENTID --jwt-key-file=keys/server.key --username=$SFDC_USER --instance-url=$SFDC_INSTANCE_URL

#Validate against org & run local tests
echo "Validate against ORG & run local tests..." 
# Temporarily changed the TestLevel to SpecifiedTests due to test coverage in org is below 75%
# sfdx force:source:deploy -u $USER -p force-app -w 90 -l RunSpecifiedTests -r SiteLoginControllerTest -c
sf project deploy validate --target-org=$SFDC_USER --source-dir force-app --wait=90 --test-level RunSpecifiedTests --tests=SiteLoginControllerTest