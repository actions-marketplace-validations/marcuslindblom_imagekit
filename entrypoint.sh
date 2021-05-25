#!/bin/bash

URL=$1

check() {
	STATE=$(curl -L -X GET 'https://analyse.imagekit.io/status/1619712183360' | jq -r '.state')
}

check #1st execution

while [ "$STATE" == "processing" ]; do
	sleep 10
	check
done

RESULT=$(curl -L -H 'Content-Type: application/json' 'https://analyse.imagekit.io/status/1619712183360')
SAVINGS=$(echo $RESULT | jq -r '.report.finalFormattedResults.totalImagePercentSaving')
PROTIP=$(echo $RESULT | jq -r '.report.finalFormattedResults.proTip')

echo "::set-output name=savings::$SAVINGS%"
echo "::set-output name=protip::$PROTIP"

exit 0
