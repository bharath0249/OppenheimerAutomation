*** Settings ***
Resource   ../resources/dispenseTaxRelief.robot
Resource   ../resources/common.robot


Test Setup     Run Keywords  Launch Oppenheimer Project Home Screen
...            AND           Instantiate session
Test Teardown  Run Keywords  Close browser
...            AND           Clear Data Base

*** Test Cases ***
Validate governer should be able to see dipense now button in red colour
     [Tags]   US5  AC1
     validate colour of dispense now button and text from CSS

Validate governer should be able to see dipense now text
     [Tags]   US5  AC2
     validate text of dispense now button

Validate clicking on dispense now button navigates to cash dispensed page
     [Tags]   US5  SMOKE  AC3
     Upload Tax details CSV File  ${valid_csv_multi_row_path}
     Click on Dispense now button
     Validate cash dispensed page is displayed
