#!/bin/bash

echo "let's create some record"
RECORD_NAME_CHARITY="www.fredbitenyo.click"
HOSTEDZONEID=$(aws route53 list-hosted-zones-by-name --dns-name fredbitenyo.click \
--query 'HostedZones[0].Id' --output text)
CHARITY_DNS=$(kubectl get ingress -o json | jq -r ".items[0].status.loadBalancer.ingress[0].hostname")
MONITORING_DNS=$(kubectl get ingress -n monitoring -o json | jq -r ".items[0].status.loadBalancer.ingress[0].hostname")
KUBE_SYSTEM_DNS=$(kubectl get ingress -n kube-system -o json | jq -r ".items[0].status.loadBalancer.ingress[0].hostname")


# record for www.fredbitenyo.click
echo "$RECORD_NAME_CHARITY"
aws route53 change-resource-record-sets \
    --hosted-zone-id "$HOSTEDZONEID" \
    --change-batch "{\"Changes\":[{
        \"Action\": \"UPSERT\",
        \"ResourceRecordSet\": {
            \"Name\": \"$RECORD_NAME_CHARITY\",
            \"Type\": \"A\",
            \"AliasTarget\": {
                \"HostedZoneId\": \"Z26RNL4JYFTOTI\",
                \"DNSName\": \"$CHARITY_DNS\",
                \"EvaluateTargetHealth\": false
            }
        }
    }]}"




# Define a list of variables
dns=( 
	$RECORD_NAME_CHARITY 
	)

sleep 50s

echo "checking dns " 
for record in "${dns[@]}"; do
	HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $record)
    if [ "${HTTP_STATUS}" -eq 200 ] || [ "${HTTP_STATUS}"  -eq 307 ] || [ "${HTTP_STATUS}" -eq 302 ] ; then
		echo -e "${LIGHT_CYAN}$record successful!"
	else
		echo -e "${LIGHT_RED}$record failed!"
	fi
done
