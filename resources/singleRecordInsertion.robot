*** Settings ***
Resource  common.robot

*** Variables ***
${valid_input_file}   inputData/singleRecordInsertion/validInsertion.json
${insert_single_record_endpoint}  /calculator/insert

*** Keywords ***
Insert single record with all valid fields usng API
   ${input_body}=  Get Json string from json file  ${valid_input_file}
   &{headers}=  create dictionary   Content-Type=application/json
   log  ${input_body}
   post on session  ${SESSION_NAME}  url=${insert_single_record_endpoint}  data=${input_body}  headers=${headers}  expected_status=202
   Set Test Data  ${input_body}

Validate record is inserted successfully in UI
   perform click on button  ${refresh_table_button}

Set Test Data
   [Arguments]   ${input_json}
   ${input_json}=  convert string to json  ${input_json}
   ${DOB}=  get value from json   ${input_json}  $..birthday
   ${gender}=  get value from json   ${input_json}  $..gender
   ${natid}=  get value from json   ${input_json}  $..natid
   ${salary}=  get value from json   ${input_json}  $..salary
   ${tax}=  get value from json   ${input_json}  $..tax
   ${converted_dob}=  convert date   ${DOB[0]}  date_format=%d%m%Y
   ${datetime_dob} =	Convert Date  ${converted_dob}  datetime
   Get Age using DOB  ${datetime_dob}


