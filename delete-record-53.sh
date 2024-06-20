#!/bin/bash

echo "let's delete some record"

RECORD_NAME_CHARITY="www.fredbitenyo.click"
HOSTEDZONEID=$(aws route53 list-hosted-zones-by-name --dns-name fredbitenyo.click \
--query 'HostedZones[0].Id' --output text)
CHARITY_DNS=$(kubectl get ingress -o json | jq -r ".items[0].status.loadBalancer.ingress[0].hostname")

# Retrieve the current record details to ensure matching values
current_record=$(aws route53 list-resource-record-sets --hosted-zone-id "$HOSTEDZONEID" --query "ResourceRecordSets[?Name == '$RECORD_NAME_CHARITY.']")

# Parse the required fields from the current record
HOSTEDZONEID_ALIAS=$(echo $current_record | jq -r '.[0].AliasTarget.HostedZoneId')
DNS_NAME=$(echo $current_record | jq -r '.[0].AliasTarget.DNSName')
TTL=$(echo $current_record | jq -r '.[0].TTL')

aws route53 change-resource-record-sets \
  --hosted-zone-id "$HOSTEDZONEID" \
  --change-batch "{
    \"Comment\": \"Deleting an A record for www.fredbitenyo.click\",
    \"Changes\": [
      {
        \"Action\": \"DELETE\",
        \"ResourceRecordSet\": {
          \"Name\": \"$RECORD_NAME_CHARITY\",
          \"Type\": \"A\",
          \"AliasTarget\": {
            \"HostedZoneId\": \"$HOSTEDZONEID_ALIAS\",
            \"DNSName\": \"$DNS_NAME\",
            \"EvaluateTargetHealth\": false
          }
        }
      }
    ]
  }"
