*** Settings ***
Documentation       Suite description

Variables           ../resources/data/testdata.py
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/login_page.robot

Test Setup          Start Test Case
Test Teardown       End Test Case

*** Test Cases ***
G-TCL1.Succesful Login with Registered Email and Password
    To Login Page
    Input Login Form    ${EmailAddressRegistered}    ${Password}
    Submit Form Login
    Login Validation

G-TCL2.Validation of Failure Login with Incorrect Email and Password Format
    To Login Page
    Input Login Form    ${FirstName}    ${Password}
    Submit Form Login
    Alert Visible Validation    ${AlertInvalidEmailFormat}

G-TCL3.Validation of Failure Login with Unregistered Email
    To Login Page
    ${randomEmail}=    Generate Random Email
    Input Login Form    ${randomEmail}    ${Password}
    Submit Form Login
    Alert Visible Validation    ${AllertMessageError}

G-TCL5.Unsuccessful Login Using Invalid Phone Number
    To Login Page
    Go To Login By Phone Number
    ${randomEmail}=    Generate Random Email
    Input Phone Number Login Form    ${randomEmail}
    Submit Request OTP
    Alert Visible Validation    ${AllertLoginSMSMessageError}
