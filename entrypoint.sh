#!/bin/bash

URL=$1

TASKID=$(curl -L -X POST -H 'Content-Type: application/json' \
--data-raw '{
	"address": "'$URL'"
}' 'https://analyse.imagekit.io/analysis' | jq -r '.taskId')

check() {
	STATE=$(curl -L -X GET 'https://analyse.imagekit.io/status/'$TASKID'' | jq -r '.state')
}

check #1st execution

while [ "$STATE" == "processing" ]; do
	sleep 10
	check
done

RESULT=$(curl -L -H 'Content-Type: application/json' 'https://analyse.imagekit.io/status/'$TASKID'')
SAVINGS=$(echo $RESULT | jq -r '.report.finalFormattedResults.totalImagePercentSaving')
PROTIP=$(echo $RESULT | jq -r '.report.finalFormattedResults.proTip')

echo "::set-output name=savings::$SAVINGS%"
echo "::set-output name=protip::$PROTIP"
echo "::set-output name=report-url::https://analyse.imagekit.io/status/'$TASKID'"

exit 0
