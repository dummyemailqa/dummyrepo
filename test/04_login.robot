*** Settings ***
Documentation       Suite description

Variables           ../resources/data/testdata.py
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/login_page.robot

Test Setup          Start Test Case
Test Teardown       End Test Case

*** Test Cases ***
TCL1-G.Succesful Login with Registered Email and Password
    Sleep    15
    To Login Page
    Input Login Form    ${EmailAddress}    ${Password}
    Submit Form Login
    Login Validation

TCL2-G.Validation of Failure Login with Incorrect Email and Password Format
    To Login Page
    Input Login Form    ${FirstName}    ${Password}
    Submit Form Login
    Alert Visible Validation    ${AlertInvalidEmailFormat}

TCL3-GValidation of Failure Login with Unregistered Email
    To Login Page
    ${randomEmail}=    Generate Random Email
    Input Login Form    ${randomEmail}    ${Password}
    Submit Form Login
    Alert Visible Validation    ${AllertMessageError}

TCL5-G.Unsuccessful Login Using Invalid Phone Number
    To Login Page
    Go To Login By Phone Number
    ${randomEmail}=    Generate Random Email
    Input Phone Number Login Form    ${randomEmail}
    Submit Request OTP
    Alert Visible Validation    ${AllertLoginSMSMessageError}
