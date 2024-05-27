*** Settings ***
Library         SeleniumLibrary
Library         String
Variables       ../resources/data/testdata.py
Variables       ../resources/locators/base_locator.py

*** Keywords ***
Wait Until Element Is Visible With Long Time
    [Arguments]    ${Element}
    Wait Until Element Is Visible    ${Element}    60

Wait Until Element Is Not Visible With Long Time
    [Arguments]    ${Element}
    Wait Until Element Is Not Visible    ${Element}    60

Alert Warning Validation Register
    [Arguments]    ${AlertMessage}
    Wait Until Element Is Visible With Long Time    ${AlertMessage}
