*** Settings ***
Library    ../lib/WebDriverManager.py
Library    SeleniumLibrary
Library    RequestsLibrary
Library    JSONLibrary
Library    DateTime
Library    String
Library    OperatingSystem
Library    Collections
Library    CSVLibrary
Resource    ../mappings/UIWebElements/HomePageElements.robot
Resource    ../mappings/properties.robot

*** Variables ***
${clear_data_base_url}   /calculator/rakeDatabase
${internal_server_error}   500

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

Get Age using DOB
    [Arguments]  ${DOB}
    ${current_date}=   get current date  result_format=datetime
    ${age}=  Evaluate  ${current_date.year}-${DOB.year}
    [Return]  ${age}

Calculate tax amount
    [Arguments]  ${salary}  ${tax}  ${gender}  ${age_of_tax_payer}
    ${variable} =	Set Variable If	 ${age_of_tax_payer} < 18	 1
    ...	        ${age_of_tax_payer} < 35	0.8
    ...	        ${age_of_tax_payer} < 50	0.5
    ...	        ${age_of_tax_payer} < 75	0.367
    ...	        ${age_of_tax_payer} > 76	0.05
    ${gender_bonus} =	Set Variable If	 "${gender}" == "M"	 0
    ...	        "${gender}" == "F"	 500
    ${bonus}=  Evaluate  ((${salary}-${tax})*${variable})+${gender_bonus}
    IF  ${bonus}<50
     ${bonus}=  Set Variable  50.00
    END
    [Return]   ${bonus}

Get masked natural id
    [Arguments]  ${natid}
    ${shortened_natid}=   get substring  ${natid}  0  4
    ${masked_natid}=  Catenate  ${shortened_natid}$$$$$$
    [Return]   ${masked_natid}









