*** Settings ***
Resource    ../resources/common.robot
Resource    ../resources/queryTaxRelief.robot

Test Setup     Run Keywords  Launch Oppenheimer Project Home Screen
...            AND           Instantiate session
Test Teardown  Run Keywords  Close browser
...            AND           Clear Data Base

*** Test Cases ***
Validate if Book Keeper is able to fetch the list of tax relief details
     [Tags]  US4  SMOKE  AC1
     Upload Tax details CSV File   ${tax_details_csv_path}
     Validate tax relief details for each person in data base

Validate if Book Keeper is able to see each person gets minimum value of relief
     [Tags]  US4  SMOKE  AC2
     Upload Tax details CSV File   ${tax_relief_less_than_50_csv}
     Validate tax relief has minimum value of 50

Validate if Book Keeper is getting proper rounded tax relief amounts
     [Tags]  US4  AC3
     Upload Tax details CSV File   ${tax_relief_rounded_off_values}
     Validate tax relief details are properly rounded off

