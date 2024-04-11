#!/bin/bash

# Load environment variables from .env file
source .env.development

# Check login status
response=$(npx retool-ccl login --status)

# If already logged in, run `npx retool-ccl dev`
if [[ $response == *"Currently logged in"* ]]; then
    {
        sleep 1;
        echo "Y"; # Enter to proceed
        sleep 1;
        echo ""; # Enter to proceed
        sleep 1;
        echo $RETOOL_SUB_DOMAIN; # Enter subdomain from secrets
        sleep 1;
        echo $RETOOL_CUSTOM_COMPONENT_TOKEN; # Enter token from secrets
        sleep 1;
    } | npx retool-ccl login # Use the login command with entered information

    # After successful login 
    # run `npx retool-ccl dev`
    response_dev=$(npx retool-ccl dev)

    # Check if the library does not exist on the backend
    if [[ $response_dev == *"Error, library does not exist on the backend"* ]]; then
        {
            sleep 1;
            echo $RETOOL_CUSTOM_COMPONENT_LABEL; # Enter to proceed
            sleep 1;
            echo $RETOOL_CUSTOM_COMPONENT_DESCRIPTION; # Enter to proceed
            sleep 1;
        } | npx retool-ccl init

        # After initialization, run `npx retool-ccl dev` again
        npx retool-ccl dev
    fi

else
    # If not logged in, perform the login process
    {
        sleep 1;
        echo ""; # Enter to proceed
        sleep 1;
        echo $RETOOL_SUB_DOMAIN; # Enter subdomain from secrets
        sleep 1;
        echo $RETOOL_CUSTOM_COMPONENT_TOKEN; # Enter token from secrets
        sleep 1;
    } | npx retool-ccl login # Use the login command with entered information

    # After successful login 
    # run `npx retool-ccl dev`
    response_dev=$(npx retool-ccl dev)

    # Check if the library does not exist on the backend
    if [[ $response_dev == *"Error, library does not exist on the backend"* ]]; then
        {
            sleep 1;
            echo $RETOOL_CUSTOM_COMPONENT_LABEL; # Enter to proceed
            sleep 1;
            echo $RETOOL_CUSTOM_COMPONENT_DESCRIPTION; # Enter to proceed
            sleep 1;
        } | npx retool-ccl init
        
        # After initialization, run `npx retool-ccl dev` again
        npx retool-ccl dev
    fi

fi
