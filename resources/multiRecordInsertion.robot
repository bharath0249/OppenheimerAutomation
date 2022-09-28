*** Settings ***
Resource  common.robot

*** Variables ***
${valid_input_file}   inputData/multiRecordInsertion/validInsertion.json
${missing_required_fields_file}   inputData/multiRecordInsertion/missingRequiredField.json
${dob_greater_than_current}       inputData/multiRecordInsertion/DOBgreaterThanCurrentDate.json
${invalid_natid}    inputData/multiRecordInsertion/invalidNatId.json
${invalid_gender_identifier}   inputData/multiRecordInsertion/invalidGenderIdentifier.json
${insert_multi_record_endpoint}  /calculator/insertMultiple

*** Keywords ***
Insert multiple records with all valid fields usng API
   ${input_body}=  Get Json string from json file  ${valid_input_file}
   &{headers}=  create dictionary   Content-Type=application/json
   log  ${input_body}
   post on session  ${SESSION_NAME}  url=${insert_multi_record_endpoint}  data=${input_body}  headers=${headers}  expected_status=202
   Set Test Data  ${input_body}

Validate multiple records is inserted successfully in UI
   ${length}=  Get length  ${bonus_list}
   perform click on button  ${refresh_table_button}
   FOR  ${i}  IN RANGE  0  ${length}
    page should contain  ${masked_natid_list[${i}]}
    page should contain  ${bonus_list[${i}]}
   END

Set Test Data
   [Arguments]   ${input_json}
   ${input_json}=  convert string to json  ${input_json}
   ${DOB}=  get value from json   ${input_json}  $..birthday
   ${gender}=  get value from json   ${input_json}  $..gender
   ${natid}=  get value from json   ${input_json}  $..natid
   ${salary}=  get value from json   ${input_json}  $..salary
   ${tax}=  get value from json   ${input_json}  $..tax
   ${length}=  Get length  ${input_json}
   @{masked_natid_list}=  Create list
   @{bonus_list}=  Create list
   FOR  ${i}  IN RANGE  0  ${length}
    ${converted_dob}=  convert date   ${DOB[${i}]}  date_format=%d%m%Y
    ${datetime_dob} =	Convert Date  ${converted_dob}  datetime
    ${age_of_tax_payer}=  Get Age using DOB  ${datetime_dob}
    ${bonus}=   Calculate tax amount  ${salary[${i}]}  ${tax[${i}]}  ${gender[${i}]}  ${age_of_tax_payer}
    ${masked_natid}=  Get masked natural id  ${natid[${i}]}
    Append to list  ${masked_natid_list}   ${masked_natid}
    Append to list  ${bonus_list}  ${bonus}
   END
   Set test variable  ${masked_natid_list}
   Set test variable  ${bonus_list}

Insert multiple records with invalid data and validate response code
   [Arguments]  ${input_body_path}  ${expected_status_code}
   ${input_body}=  Get Json string from json file  ${input_body_path}
   &{headers}=  create dictionary   Content-Type=application/json
   log  ${input_body}
   post on session  ${SESSION_NAME}  url=${insert_multi_record_endpoint}  data=${input_body}  headers=${headers}  expected_status=${expected_status_code}

Validate record is not inserted in UI
   perform click on button  ${refresh_table_button}
   page should not contain  ${tax_relief_table}
   page should contain   No records at the moment



