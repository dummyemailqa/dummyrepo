*** Settings ***
Library         SeleniumLibrary
Library         String
Variables       ../resources/data/testdata.py
Variables       ../resources/locators/base_locator.py
Variables       ../resources/locators/cart_page_locator.py
Resource        ../base/base.robot


*** Keywords ***
Alert Success Validation
    Wait Until Element Is Visible    ${MessageSuccessAlert}
    Click Element    ${CloseMessageBtn}

Wait Until Element Is Visible With Long Time
    [Arguments]    ${Element}
    Wait Until Element Is Visible    ${Element}    45

Wait Until Element Is Visible in 10s
    [Arguments]    ${Element}
    Wait Until Element Is Visible    ${Element}    10

Wait Until Element Is Not Visible With Long Time
    [Arguments]    ${Element}
    Wait Until Element Is Not Visible    ${Element}    45

Alert Warning Validation Register
    [Arguments]    ${AlertMessage}
    Wait Until Element Is Visible    ${AlertMessage}
