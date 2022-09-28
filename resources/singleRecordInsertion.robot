*** Settings ***
Resource  common.robot

*** Variables ***
${valid_input_file}   inputData/singleRecordInsertion/validInsertion.json
${missing_required_fields_file}   inputData/singleRecordInsertion/missingRequiredField.json
${dob_greater_than_current}       inputData/singleRecordInsertion/DOBgreaterThanCurrentDate.json
${invalid_natid}    inputData/singleRecordInsertion/invalidNatId.json
${invalid_gender_identifier}   inputData/singleRecordInsertion/invalidGenderIdentifier.json
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
   page should contain  ${masked_natid}
   page should contain  ${bonus}

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
   ${age_of_tax_payer}=  Get Age using DOB  ${datetime_dob}
   ${bonus}=   Calculate tax amount  ${salary[0]}  ${tax[0]}  ${gender[0]}  ${age_of_tax_payer}
   ${masked_natid}=  Get masked natural id  ${natid[0]}
   Set Test Variable  ${masked_natid}
   Set Test Variable  ${bonus}

Insert single record with invalid data and validate response code
   [Arguments]  ${input_body_path}  ${expected_status_code}
   ${input_body}=  Get Json string from json file  ${input_body_path}
   &{headers}=  create dictionary   Content-Type=application/json
   log  ${input_body}
   post on session  ${SESSION_NAME}  url=${insert_single_record_endpoint}  data=${input_body}  headers=${headers}  expected_status=${expected_status_code}

Validate record is not inserted in UI
   perform click on button  ${refresh_table_button}
   page should not contain  ${tax_relief_table}
   page should contain   No records at the moment



