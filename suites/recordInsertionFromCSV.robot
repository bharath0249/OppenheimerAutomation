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
     Validate multiple records is inserted successfully in UI


