*** Settings ***
Library    ../lib/WebDriverManager.py
Library    SeleniumLibrary
Library    RequestsLibrary
Resource    ../mappings/UIWebElements/HomePageElements.robot
Resource    ../mappings/properties.robot

*** Keywords ***
Launch Oppenheimer Project Home Screen
    ${driver_path}=    Get Driver Path With Browser        ${BROWSER}
    Open Browser          ${BASE_URL}     ${BROWSER}      executable_path=${driver_path}  options=add_argument("--ignore-certificate-errors");add_argument("--start-maximized")
    Set Selenium Implicit Wait   60s

Instantiate session
    Create Session    ${SESSION_NAME}  ${BASE_URL}





