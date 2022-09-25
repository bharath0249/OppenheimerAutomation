*** Settings ***
Library    ../lib/driverManager.py
Library    SeleniumLibrary
Resource    ../mappings/UIWebElements/HomePageElements.robot

*** Keywords ***
Launch Oppenheimer Project Home Screen
    ${driver_path}=    Get Driver Path With Browser        Chrome
    Open Browser          http://localhost:8080     Chrome       executable_path=${driver_path}


