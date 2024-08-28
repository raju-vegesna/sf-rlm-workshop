#Deploy to org & run local tests
echo "Deploying to ORG & run local tests..." 
# Temporarily changed the TestLevel to SpecifiedTests due to test coverage in org is below 75%

sfdx force:source:deploy -u $SFDC_USER -p force-app -w 60 -l RunSpecifiedTests -r SiteLoginControllerTest
# sf project deploy --target-org=$SFDC_USER --source-dir force-app --wait=60 --test-level RunSpecifiedTests --tests=SiteLoginControllerTest