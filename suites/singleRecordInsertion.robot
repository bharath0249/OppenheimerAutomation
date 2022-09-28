*** Settings ***
Resource    ../resources/common.robot
Resource    ../resources/singleRecordInsertion.robot

Test Setup     Run Keywords  Launch Oppenheimer Project Home Screen
...            AND           Instantiate session
Test Teardown  Run Keywords  Close browser
...            AND           Clear Data Base

*** Test Cases ***
Validate if Clerk is able to insert single record with all valid details
     [Tags]  US1  SMOKE  AC1
     Insert single record with all valid fields usng API
     Validate record is inserted successfully in UI

Validate Clerk is not able to insert single record when required fields are missing
     [Tags]  US1  AC2
     Insert single record with invalid data and validate response code  ${missing_required_fields_file}   ${internal_server_error}
     Validate record is not inserted in UI

Validate Clerk is not able to insert single record when DOB is greater than current date
     [Tags]  US1  AC3
     Insert single record with invalid data and validate response code  ${dob_greater_than_current}   ${internal_server_error}
     Validate record is not inserted in UI

Validate Clerk is not able to insert single record when nat id is invalid
     [Tags]  US1  AC4
     Insert single record with invalid data and validate response code  ${invalid_natid}   ${internal_server_error}
     Validate record is not inserted in UI

Validate Clerk is not able to insert single record when gender identifier is invalid
     [Tags]  US1  AC5
     Insert single record with invalid data and validate response code   ${invalid_gender_identifier}   ${internal_server_error}
     Validate record is not inserted in UI


