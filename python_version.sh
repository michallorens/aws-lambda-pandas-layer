python --version | jq -R '{ version: match("(\\d\\.\\d)(\\.\\d)?").captures[0].string }'