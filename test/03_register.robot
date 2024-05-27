*** Settings ***
Documentation       Suite description

Variables           ../resources/data/testdata.py
Variables           ../resources/locators/register_locator.py
Resource            ../base/common.robot
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/register_page.robot

Test Setup          Start Test Case
Test Teardown       End Test Case


*** Test Cases ***
G-TCR2.Validation of Registration Failure with Empty Mandatory Fields
    [Tags]    register    daily
    To Register Page
    Input Register Form    ${EmailAddress}    ${Empty}    ${LastName}    ${Empty}    ${Empty}    ${Empty}
    Click Element    ${SubmitRegisterButton}
    Alert Warning Validation Register    ${RegisterAlertMessageFirtName}

G-TCR3.Validation of Registration Failure with Weak Password
    [Tags]    register    daily
    To Register Page
    Input Register Form
    ...    ${EmailAddress}
    ...    ${FirstName}
    ...    ${LastName}
    ...    ${LastName}
    ...    ${LastName}
    ...    ${PhoneNumber}
    Click Element    ${SubmitRegisterButton}
    Alert Warning Validation Register    ${RegisterAlerMessageWeakPassword}

G-TCR4.Validation of Registration Failure with Password Confirmation Mismatch
    [Tags]    register    daily
    To Register Page
    Input Register Form
    ...    ${EmailAddress}
    ...    ${FirstName}
    ...    ${LastName}
    ...    ${Password}
    ...    ${LastName}
    ...    ${PhoneNumber}
    Click Element    ${SubmitRegisterButton}
    Alert Warning Validation Register    ${RegisterAlertMessagePasswordNotMatch}

G-TCR5.Validation of Registration Failure with Duplicate Email/Phone Number
    [Tags]    register    daily
    To Register Page
    Input Register Form
    ...    ${EmailAddressRegistered}
    ...    ${FirstName}
    ...    ${LastName}
    ...    ${Password}
    ...    ${Password}
    ...    ${PhoneNumber}
    Click Element    ${SubmitRegisterButton}
    Alert Warning Validation Register    ${RegisterAlerrMessageInvalidRegister}
