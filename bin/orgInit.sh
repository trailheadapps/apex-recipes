#!/bin/bash

DURATION=7

if [ "$#" -eq 1 ]; then
  DURATION=$1
fi

sfdx force:org:create -a apex-recipes -s -f config/project-scratch-def.json -d $DURATION
sfdx force:source:push
sfdx force:user:permset:assign -n Proving_With_Security_Enforced_works
sfdx force:org:open -p /lightning/page/home
echo "Org is set up"