*** Settings ***
Resource    ../resources/common.robot
Resource    ../resources/singleRecordInsertion.robot

Test Setup     Run Keywords  Launch Oppenheimer Project Home Screen
...            AND           Instantiate session
Test Teardown  Run Keywords  Close browser
...            AND           Clear Data Base

*** Test Cases ***
Validate if Clerk is able to insert single record with all valid details
     Insert single record with all valid fields usng API
     Validate record is inserted successfully in UI
