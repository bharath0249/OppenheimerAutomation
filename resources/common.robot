*** Settings ***
Library    ../lib/WebDriverManager.py
Library    SeleniumLibrary
Library    RequestsLibrary
Library    JSONLibrary
Library    DateTime
Library    OperatingSystem
Resource    ../mappings/UIWebElements/HomePageElements.robot
Resource    ../mappings/properties.robot

*** Variables ***
${clear_data_base_url}   /calculator/rakeDatabase

*** Keywords ***
Launch Oppenheimer Project Home Screen
    ${driver_path}=    Get Driver Path With Browser        ${BROWSER}
    Open Browser          ${BASE_URL}     ${BROWSER}      executable_path=${driver_path}  options=add_argument("--ignore-certificate-errors");add_argument("--start-maximized")
    Set Selenium Implicit Wait   60s

Instantiate session
    Create Session    ${SESSION_NAME}  ${BASE_URL}

Get Json string from json file
    [Arguments]  ${path}
    ${json_string}=  get file  ${path}
    [Return]  ${json_string}

Clear Data Base
    post on session   ${SESSION_NAME}  url=${clear_data_base_url}

perform click on button
    [Arguments]  ${locator}
    wait until element is visible  ${locator}
    click button  ${locator}









