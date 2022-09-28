*** Settings ***
Resource    ../resources/common.robot
Resource    ../resources/recordInsertionFromCSV.robot

Test Setup     Run Keywords  Launch Oppenheimer Project Home Screen
...            AND           Instantiate session
Test Teardown  Run Keywords  Close browser
...            AND           Clear Data Base

*** Test Cases ***
Validate if Clerk is able to upload csv with single record and see the output
     [Tags]  SMOKE  AC1
     Upload Tax details CSV File  ${valid_csv_path}
     Validate multiple records are inserted successfully in UI

Validate if Clerk is able to upload csv with multiple records and see the output
     [Tags]  SMOKE  AC2
     Upload Tax details CSV File  ${valid_csv_multi_row_path}
     Validate multiple records are inserted successfully in UI

Validate Clerk is not able to upload csv with missing headers
     [Tags]  AC3
     Upload invalid Tax details CSV File  ${csv_with_missing_headers}
     Validate record is not inserted in UI

Validate Clerk is not able to upload csv with wrong header name
     [Tags]  AC4
     Upload invalid Tax details CSV File  ${csv_with_wrong_header}
     Validate record is not inserted in UI


