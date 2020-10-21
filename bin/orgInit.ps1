param([int]$duration)

if (!$duration) {
    $duration = 7
}

sfdx force:org:create -f config/project-scratch-def.json --setalias ApexRecipes --durationdays $duration --setdefaultusername --json --loglevel fatal
sfdx force:source:push
sfdx force:user:permset:assign -n Apex_Recipes
sfdx force:user:permset:assign -n Walkthroughs
sfdx force:data:tree:import -p ./data/data-plan.json
sfdx force:data:tree:import -p ./data/data-plan2.json
sfdx force:apex:execute --apexcodefile data/setup.apex
sfdx force:org:open
Write-Host "Org is set up"