*** Settings ***
Documentation   Suite description
Variables   ../resources/data/testdata.py
Variables   ../resources/locators/register_locator.py
Resource    ../base/common.robot
Resource    ../base/test_setup.robot
Resource    ../base/base.robot
Resource    ../pages/register_page.robot


Test Setup  Start Test Case
Test Teardown    End Test Case

*** Test Cases ***
TCR2-G.Validation of Registration Failure with Empty Mandatory Fields
    [Tags]      register   daily
    To Register Page
    Input Register Form                         ${EmailAddress}    ${Empty}    ${LastName}    ${Empty}    ${Empty}    ${Empty}
    Click Element                               ${SubmitRegisterButton}
    Alert Warning Validation Register           ${RegisterAlertMessageFirtName}

TCR3-G.Validation of Registration Failure with Weak Password
    [Tags]      register   daily
    To Register Page
    Input Register Form                         ${EmailAddress}  ${FirstName}  ${LastName}  ${LastName}  ${LastName}  ${PhoneNumber}
    Click Element                               ${SubmitRegisterButton} 
    Alert Warning Validation Register           ${RegisterAlerMessageWeakPassword}     