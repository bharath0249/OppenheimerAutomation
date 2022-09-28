*** Settings ***
Resource  common.robot
Resource  recordInsertionFromCSV.robot

*** Variables ***
${get_tax_relief_endpoint}    /calculator/taxRelief
${tax_details_csv_path}     ${EXECDIR}/inputData/queryTaxRelief/validCSV.csv
${tax_relief_less_than_50_csv}   ${EXECDIR}/inputData/queryTaxRelief/taxReliefLessThan50.csv
${tax_relief_rounded_off_values}   ${EXECDIR}/inputData/queryTaxRelief/taxRelieRoundedOffValues.csv

*** Keywords ***
Validate tax relief details for each person in data base
   &{headers}=  create dictionary   Content-Type=application/json
   ${response}=  get on session  ${SESSION_NAME}  url=${get_tax_relief_endpoint}  expected_status=200
   ${response_body}=  set Variable   ${response.json()}
   @{response_natids}=  get value from json    ${response_body}  $..natid
   @{response_bonus_amounts}=  get value from json    ${response_body}  $..relief
   @{response_names}=  get value from json   ${response_body}  $..name
   lists should be equal   ${response_natids}  ${masked_natid_list}
   lists should be equal   ${response_bonus_amounts}   ${bonus_list}
   lists should be equal   ${response_names}   ${names_list}

Validate tax relief has minimum value of 50
      &{headers}=  create dictionary   Content-Type=application/json
   ${response}=  get on session  ${SESSION_NAME}  url=${get_tax_relief_endpoint}  expected_status=200
   ${response_body}=  set Variable   ${response.json()}
   @{response_bonus_amounts}=  get value from json    ${response_body}  $..relief
   FOR  ${tax_relief}  IN  @{response_bonus_amounts}
     Should be equal   ${tax_relief}  50.00
   END

Validate tax relief details are properly rounded off
   &{headers}=  create dictionary   Content-Type=application/json
   ${response}=  get on session  ${SESSION_NAME}  url=${get_tax_relief_endpoint}  expected_status=200
   ${response_body}=  set Variable   ${response.json()}
   @{response_bonus_amounts}=  get value from json    ${response_body}  $..relief
   lists should be equal   ${response_bonus_amounts}   ${bonus_list}