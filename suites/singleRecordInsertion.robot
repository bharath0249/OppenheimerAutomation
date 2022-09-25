*** Settings ***
Resource    ../resources/common.robot

Test Setup    Launch Oppenheimer Project Home Screen
Test Teardown    Close browser

*** Test Cases ***
Validate if Clerk is able to insert single record with all valid details
     wait until element is visible     ${visit_swagger_xpath}
     click element    ${visit_swagger_xpath}
