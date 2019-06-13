#!/bin/bash

IFS=$'\n'

for key in `cat keys.txt`; do
	encryption=`node encryption.js $key`

	password=`echo $encryption | awk -F"|" '{ print $1 }'`
	payload=`echo $encryption | awk -F"|" '{ print $2 }'`

	request=`curl -s 'https://<whisper.server.address>/secret' \
		-XPOST \
		-H 'Accept: */*' \
		-H 'Content-Type: text/plain;charset=UTF-8' \
		--data-binary "$payload"`

	response=`echo $request | sed 's/{"message":"//g'`
	response=`echo $response | sed 's/"}//g'`

	url="https://<whisper.server.address>/#/s/$response/$password"

	echo "Key $key => password = $password | URL = $url"
	
	sleep 1
done
