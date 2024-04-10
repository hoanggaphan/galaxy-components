#!/bin/bash

# Load environment variables from .env file
source .env.development

# Check login status
response=$(npx retool-ccl login --status)

# If already logged in, run `npx retool-ccl dev`
if [[ $response == *"Currently logged in to https://$SUB_DOMAIN.retool.com."* ]]; then
    npx retool-ccl dev
else
    # If not logged in, perform the login process
    {
        echo ""; # Enter to proceed
        sleep 1;
        echo "${{secrets.SUB_DOMAIN}}"; # Enter subdomain from secrets
        sleep 1;
        echo "${{secrets.RETOOL_CUSTOM_COMPONENT_TOKEN}}"; # Enter token from secrets
        sleep 1;
    } | npx retool-ccl login # Use the login command with entered information

    # After successful login, run `npx retool-ccl dev`
    npx retool-ccl dev 
fi
