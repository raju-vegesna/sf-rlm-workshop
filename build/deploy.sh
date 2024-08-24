#Deploy to org & run local tests
echo "Deploying to ORG & run local tests..." 
sfdx force:source:deploy -u $SFDC_USER -p force-app -w 60 -l RunLocalTests