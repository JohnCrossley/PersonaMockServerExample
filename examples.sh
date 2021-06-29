#!/bin/sh

# build from source using:
# $ mvn clean compile install
#
# run jetty (lightweight J2EE server) with:
# mvn jetty:run


SERVER=http://localhost:9090

echo "===================================================================================================="
echo "=== Persona extraction from path (profile)                                                     ====="
echo "===================================================================================================="

curl -v $SERVER/emily/profile

curl -v $SERVER/isla/profile

echo "--  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --\n\n"



echo "===================================================================================================="
echo "=== Persona extraction through authorisation header (profile)                                  ====="
echo "===================================================================================================="

curl -v -H "Authorization: Basic aaaaaaaa" $SERVER/myevents

curl -v -H "Authorization: Basic bbbbbbbb" $SERVER/myevents

echo "--  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --\n\n"



echo "===================================================================================================="
echo "=== Persona extraction: persona doesn't have a body file, so default gets used instead         ====="
echo "===================================================================================================="

curl -v $SERVER/unknown/profile

echo "--  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --\n\n"



echo "===================================================================================================="
echo "=== No persona or default file matching - error response                                       ====="
echo "===================================================================================================="

curl -v $SERVER/location/666 && echo "\n"

echo "--  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --\n\n"



echo "===================================================================================================="
echo "=== Path doesn't match any route - error message                                               ====="
echo "===================================================================================================="

curl -v $SERVER/hmm_no/666 && echo "\n"

echo "--  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --\n\n"



echo "===================================================================================================="
echo "=== Response delay example (long_running using PMS_Delay)                                      ====="
echo "===================================================================================================="

curl -v $SERVER/long_running

echo "--  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --\n\n"



echo "===================================================================================================="
echo "=== Custom response headers (redirect)                                                         ====="
echo "===================================================================================================="

curl -v -L $SERVER/redirect?id=GOOG && echo "\n"

echo "--  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --\n\n"



echo "===================================================================================================="
echo "=== Custom ResponseHandler (custom_responder) - checks POST body and sends validation response ====="
echo "===================================================================================================="

curl -v -H "Content-Type: application/json" -d '{ "email": "valid@example.com" }' $SERVER/profile/save && echo "\n"

curl -v -H "Content-Type: application/json" -d '{ "email": "not_valid@bad" }' $SERVER/profile/save && echo "\n"

echo "--  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --\n\n"



echo "===================================================================================================="
echo "=== Passthrough (passthrough) - delegates to the container to serve up a static file           ====="
echo "===================================================================================================="

curl -v $SERVER/static/some_file.txt

echo "--  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --  --  cut here  --  --  --  --\n\n"
