#!/bin/bash

# Shell script to upload an iOS build's debug symbols (dSYM file) to AppPulse Mobile in order to symbolicate crash logs.
#
# This script can be invoked during Xcode build or by command line.
#
# To invoke during Xcode build:
#   1. In Xcode, select your project in the navigator and click your application target.
#   2. Select the Build Phases tab in the settings editor.
#   3. Click the + icon and choose "New Run Script Phase".
#   4. Add the following two lines of code to the new phase,
#           SCRIPT=`/usr/bin/find ${FRAMEWORK_SEARCH_PATHS} -name apppulse_upload_dsym\.sh 2>/dev/null | head -n 1`
#           $SCRIPT -tenant <tenant id> -client <client id> -secret <client Secret>"
#
# To invoke by a command line:
#   1. Find the script apppulse_upload_dsym.sh under AppPulsemobile.framework
#   2. Run: apppulse_upload_dsym.sh -tenant <tenant id> -client <client id> -secret <client Secret> -appkey <application key> -dsym <path to dSYM file> -infoplist <path to the app info.plist file>


#####################
### Usage
#####################
function usage {

    echo "Upload dSYM file for the given application"
    echo "      Usage: apppulse_upload_dsym.sh -tenant <tenant id> -client <client id> -secret <client Secret> -appkey <application key> -dsym <path to dSYM file> -infoplist <path to the app info.plist file>"
    echo
    echo "List uploaded dSYM files for the given application"
    echo "      Usage: apppulse_upload_dsym.sh -tenant <tenant id> -client <client id> -secret <client Secret> -appkey <application key> -status"
    echo
    echo "Options:"
    echo "[-tenant <tenant id>] tenant id"
    echo "[-client <client id>] obtained by the application administrator and used for authentication"
    echo "[-secret <client Secret>] obtained by the application administrator and used for authentication"
    echo "[-appkey <application key>] application key. Optional when running in Xcode"
    echo "[-dsym <path to dSYM file>] full path to the application dSYM file. Optional when running in Xcode"
    echo "[-infoplist <path to the app info.plist file> full path to application info.plist file. Optional when running in Xcode"
    echo "[-status] list uploaded dSYM files for the given application"
    echo "[-uploadsimulatorbuilds] upload dSYM file also when built for simulator"
}


#####################
### Get Token
#####################
function get_token {

    local CLIENT_ID_PARAM=$1
    local SECRET_PARAM=$2
    local GET_TOKEN_URL_PARAM=$3

    echo "curl  --silent --data \"{\"clientId\":\"$CLIENT_ID_PARAM\",  \"clientSecret\":\"$SECRET_PARAM\"}\" -H \"Content-Type: application/json;charset=UTF-8\" ${GET_TOKEN_URL_PARAM}"
    SERVER_RESPONSE=`curl  --silent --data "{\"clientId\":\"$CLIENT_ID_PARAM\",  \"clientSecret\":\"$SECRET_PARAM\"}" -H "Content-Type: application/json;charset=UTF-8" "${GET_TOKEN_URL_PARAM}"`

    if [ -z `echo $SERVER_RESPONSE | grep token` ]
        then
            echo "Failed to get token from AppPulse Mobile: $SERVER_RESPONSE"
            exit
    fi

    TOKEN=`echo $SERVER_RESPONSE | tr ',{}' '\n' | grep token | awk -F: '{print $2}'`
    TOKEN=`echo "${TOKEN//\"}"`

}


#####################
### Show Status
#####################
function show_status {

    echo "Retrieving Status..."
    LIST_URL="$URL/mobile/openapi/rest/$OPEN_API_VERSION/symbolication/$APP_KEY/listSymFiles"
    SERVER_RESPONSE=`curl --silent -H "Authorization: Bearer $TOKEN;Accept:application/json" $LIST_URL`
    echo "$SERVER_RESPONSE"
}

#########################################################
echo "AppPulse Mobile: Started Post-Build dSYM upload"

### Parse Arguments

while [[ $# > 0 ]]
do
key="$1"

case $key in
	-tenant)
    echo "Tenant: $2"
    TENANT_ID="$2"
    shift # past argument
    ;;
    -secret)
    echo "Secret: $2"
    SECRET="$2"
    shift # past argument
    ;;
    -client)
    echo "Client Key: $2"
    CLIENT_ID="$2"
    shift # past argument
    ;;
    -dsym)
    echo "dSYM: $2"
    DSYM_FILE="$2"
    shift # past argument
    ;;
    -appkey)
    echo "App Key: $2"
    APP_KEY="$2"
    shift # past argument
    ;;
    -url)
    echo "URL: $2"
    URL="$2"
    shift # past argument
    ;;
    -infoplist)
    echo "Info plist: $2"
    INFO_PLIST_FILE="$2"
    shift # past argument
    ;;
    -uploadsimulatorbuilds)
    echo "Upload Simulator Builds: On"
    UPLOAD_SIMULATOR_BUILDS=1
    ;;
    -status)
    echo "Show Status: On"
    SHOW_STATUS=1
    ;;

    *)
    # unknown option
    ;;
esac
shift # past argument or value
done

### Check required arguments

if [ -z $TENANT_ID ] 
	then
		echo "Missing Tenant argument"
        usage
		exit -1
fi

if [ -z $SECRET ] 
	then
		echo "Missing Secret argument"
        usage
		exit -1
fi

if [ -z $CLIENT_ID ] 
	then
		echo "Missing Client argument"
        usage
		exit -1
fi

### App Key
if [ -z $APP_KEY ]
    then
        if [ -z $SRCROOT ]
            then
                echo "Missing Application Key: Run in Xcode or add -appkey argument"
                usage
                exit -1
            else
                HPRUMMONITOR_PLIST_FILE=`find "$SRCROOT" -name hprummonitor.plist`
                APP_KEY=`defaults read "$HPRUMMONITOR_PLIST_FILE" AppId`
        fi
fi
echo "App Key = $APP_KEY"


### URL
#APPPULSE_URL=`defaults read "$HPRUMMONITOR_PLIST_FILE" cmBaseUrl`
if [ -z $URL ]
    then
        URL="https://apppulse-mobile.saas.hpe.com"
fi

OPEN_API_VERSION="v1"
GET_TOKEN_URL="$URL/mobile/openapi/rest/$OPEN_API_VERSION/$TENANT_ID/oauth/token"
echo "GET_TOKEN_URL=$GET_TOKEN_URL"

if [ "$SHOW_STATUS" == "1" ]
    then
        get_token $CLIENT_ID $SECRET $GET_TOKEN_URL
        show_status
        exit
fi


echo "DWARF_DSYM_FOLDER_PATH=$DWARF_DSYM_FOLDER_PATH"
echo "DWARF_DSYM_FILE_NAME=$DWARF_DSYM_FILE_NAME" 
echo "INFOPLIST_FILE=$INFOPLIST_FILE"

if [ -z $DSYM_FILE ] 
	then
		if [ -z $DWARF_DSYM_FILE_NAME ] || [ -z $DWARF_DSYM_FOLDER_PATH ]
			then
				echo "Missing dSYM file: Run in Xcode or add -dsym argument"
                usage
				exit -1
			else
				DSYM_FILE="$DWARF_DSYM_FOLDER_PATH/$DWARF_DSYM_FILE_NAME"
				DSYM_FILE_NAME="$DWARF_DSYM_FILE_NAME"
		fi	
	else
		DSYM_FILE_NAME=`echo ${DSYM_FILE##*/}`								
fi			
echo "dSYM file: $DSYM_FILE"
echo "dSYM file name: $DSYM_FILE_NAME"

if [ -z $INFO_PLIST_FILE ]
	then
		if [ -z $INFOPLIST_FILE ]
			then
				echo "Missing info.plist file: Run in Xcode or add -infoplist argument"
                usage
				exit -1
			else
				INFO_PLIST_FILE="$SRCROOT/$INFOPLIST_FILE"
		fi
fi
echo "Info plist: $INFO_PLIST_FILE"					

### Check if it is buit for simulator

if [ ! "$UPLOAD_SIMULATOR_BUILDS" == "1" ] && [ "$EFFECTIVE_PLATFORM_NAME" == "-iphonesimulator" ]
    then
        echo "Skipping dSYM upload: Simulator build"
        exit
fi


# Temp Dir
TMP_DIR=`/usr/bin/mktemp -d -t apppulse`
ZIPPED_DSYM="${TMP_DIR}/${DSYM_FILE_NAME}-1.zip"
echo "Zipped dSYM = $ZIPPED_DSYM"


### App Version
APP_VERSION=`defaults read "$INFO_PLIST_FILE" CFBundleShortVersionString`
echo "App Version = $APP_VERSION"

UPLOAD_URL="$URL/mobile/openapi/rest/$OPEN_API_VERSION/symbolication/$APP_KEY/$APP_VERSION/uploadSym"
echo "UPLOAD_URL=$UPLOAD_URL"


DSYM_DWARFDUMP=`xcrun dwarfdump --uuid "$DSYM_FILE"`


DSYM_UUIDS=`xcrun dwarfdump --uuid "$DSYM_FILE" | tr '[:upper:]' '[:lower:]' | tr -d '-'| awk '{print $2}' | xargs | sed 's/ /,/g'`
echo "DSYM_UUIDS = $DSYM_UUIDS"


### Zip
echo "Archiving dSYM file: $DSYM_FILE..."
echo "/usr/bin/zip -r --quiet \"${ZIPPED_DSYM}\" \"${DSYM_FILE}\""
/usr/bin/zip -r --quiet "${ZIPPED_DSYM}" "${DSYM_FILE}"

### Get Token
get_token $CLIENT_ID $SECRET $GET_TOKEN_URL

### Upload
SERVER_RESPONSE=`curl --write-out %{http_code} --silent -H "Authorization: Bearer $TOKEN;Accept:application/json" -F file=@"$ZIPPED_DSYM" $UPLOAD_URL`
echo "Upload response: $SERVER_RESPONSE"

if [ "$SERVER_RESPONSE" == "200" ]; then
    echo "AppPulse Mobile Successfully uploaded debug symbols"
 else
	echo "AppPulse Mobile: Failed to upload debug symbols"
fi


### Cleanup
/bin/rm -f -d -r "${TMP_DIR}"