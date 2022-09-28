*** Settings ***
Resource    ../resources/common.robot
Resource    ../resources/multiRecordInsertion.robot

Test Setup     Run Keywords  Launch Oppenheimer Project Home Screen
...            AND           Instantiate session
Test Teardown  Run Keywords  Close browser
...            AND           Clear Data Base

*** Test Cases ***
Validate if Clerk is able to insert multiple records with all valid details
     [Tags]  SMOKE  AC2
     Insert multiple records with all valid fields usng API
     Validate multiple records is inserted successfully in UI

Validate Clerk is not able to insert multiple records when required fields are missing
     [Tags]  AC3
     Insert multiple records with invalid data and validate response code  ${missing_required_fields_file}   ${internal_server_error}
     Validate record is not inserted in UI

Validate Clerk is not able to insert multiple records when DOB is greater than current date
     [Tags]  AC3
     Insert multiple records with invalid data and validate response code  ${dob_greater_than_current}   ${internal_server_error}
     Validate record is not inserted in UI

Validate Clerk is not able to insert multiple records when nat id is invalid
     [Tags]  AC4
     Insert multiple records with invalid data and validate response code  ${invalid_natid}   ${internal_server_error}
     Validate record is not inserted in UI

Validate Clerk is not able to insert multiple records when gender identifier is invalid
     [Tags]  AC5
     Insert multiple records with invalid data and validate response code   ${invalid_gender_identifier}   ${internal_server_error}
     Validate record is not inserted in UI


