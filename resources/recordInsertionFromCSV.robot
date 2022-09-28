*** Settings ***
Resource  common.robot

*** Variables ***
${valid_csv_path}   ${EXECDIR}/inputData/recordInsertionFromCSV/validCSV.csv
${valid_csv_multi_row_path}    ${EXECDIR}/inputData/recordInsertionFromCSV/validCSVMultiRow.csv
${csv_with_missing_headers}    ${EXECDIR}/inputData/recordInsertionFromCSV/CSVWithMissingHeaders.csv
${csv_with_wrong_header}       ${EXECDIR}/inputData/recordInsertionFromCSV/CSVWithInvalidHeaderName.csv

*** Keywords ***
Upload Tax details CSV File
    [Arguments]  ${csv_path}
    sleep  5s
    wait until element is enabled  ${upload_csv_input}
    choose file  ${upload_csv_input}  ${csv_path}
    Set Test Data   ${csv_path}

Validate records are reflected in UI
    perform click on button  ${refresh_table_button}
    sleep  2s
    page should not contain  No records at the moment

Set Test Data
   [Arguments]  ${csv_path}
   ${csv_associative}=  read csv file to associative    ${csv_path}
   ${length}=  Get length  ${csv_associative}
   @{masked_natid_list}=  Create list
   @{bonus_list}=  Create list
   FOR  ${i}  IN RANGE  0  ${length}
    ${DOB}=  set variable  ${csv_associative[${i}]}[birthday]
    ${gender}=  set variable   ${csv_associative[${i}]}[gender]
    ${natid}=  set variable   ${csv_associative[${i}]}[natid]
    ${salary}=  set variable    ${csv_associative[${i}]}[salary]
    ${tax}=  set variable  ${csv_associative[${i}]}[tax]
    ${converted_dob}=  convert date   ${DOB}  date_format=%d%m%Y
    ${datetime_dob} =	Convert Date  ${converted_dob}  datetime
    ${age_of_tax_payer}=  Get Age using DOB  ${datetime_dob}
    ${bonus}=   Calculate tax amount  ${salary}  ${tax}  ${gender}  ${age_of_tax_payer}
    ${masked_natid}=  Get masked natural id  ${natid}
    Append to list  ${masked_natid_list}   ${masked_natid}
    Append to list  ${bonus_list}  ${bonus}
   END
   Set test variable  ${masked_natid_list}
   Set test variable  ${bonus_list}

Validate multiple records are inserted successfully in UI
   ${length}=  Get length  ${bonus_list}
   perform click on button  ${refresh_table_button}
   FOR  ${i}  IN RANGE  0  ${length}
    page should contain  ${masked_natid_list[${i}]}
    page should contain  ${bonus_list[${i}]}
   END

Validate record is not inserted in UI
   perform click on button  ${refresh_table_button}
   page should not contain  ${tax_relief_table}
   page should contain   No records at the moment

Upload invalid Tax details CSV File
    [Arguments]  ${csv_path}
    sleep  5s
    wait until element is enabled  ${upload_csv_input}
    choose file  ${upload_csv_input}  ${csv_path}