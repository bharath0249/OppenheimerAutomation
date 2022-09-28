*** Settings ***
Resource  common.robot
Resource  recordInsertionFromCSV.robot

*** Variables ***
#Colour code for red
${dispense_button_background_color_code}    rgba(220, 53, 69, 1)
#Colour code for white
${dispense_button_text_color_code}    rgba(255, 255, 255, 1)
${dispense_now_text}   Dispense Now
${cash_dispensed_text}   Cash dispensed
${cash_dispensed_url}   /dispense

*** Keywords ***
validate colour of dispense now button and text from CSS
    ${button_colour}=   get CSS property Value  ${dispence_now_button}  background-color
    ${text_colour}=   get CSS property Value  ${dispence_now_button}  color
    Should be equal as strings   ${button_colour}  ${dispense_button_background_color_code}
    Should be equal as strings   ${text_colour}    ${dispense_button_text_color_code}

validate text of dispense now button
    ${text}=   get element attribute   ${dispence_now_button}  text
    Should be equal as strings  ${text}  ${dispense_now_text}

Click on Dispense now button
    scroll element into view   ${dispence_now_button_xpath}
    wait until element is enabled   ${dispence_now_button_xpath}
    click element  ${dispence_now_button_xpath}

Validate cash dispensed page is displayed
    location should contain  ${cash_dispensed_url}
    page should contain   ${cash_dispensed_text}

Get CSS Property Value
    [Arguments]    ${locator}    ${attribute name}
    ${css}=         Get WebElement    ${locator}
    ${prop_val}=    Call Method       ${css}    value_of_css_property    ${attribute name}
    [Return]     ${prop_val}