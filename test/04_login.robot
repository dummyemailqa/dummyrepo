*** Settings ***
Documentation   Suite description
Variables   ../resources/data/testdata.py
Resource    ../base/test_setup.robot
Resource    ../base/base.robot
Resource    ../pages/login_page.robot

Test Setup  Start Test Case
Test Teardown    End Test Case

*** Test Cases ***
TCL1-G.Succesful Login with Registered Email and Password
    To Login Page
    Input Login Form    ${EmailAddress}    ${Password}
    Submit Form Login
    Login Validation

TCL2-G.Validation of Failure Login with Incorrect Email and Password Format
    To Login Page
    Input Login Form    ${FirstName}    ${Password}
    Submit Form Login
    Alert Visible Validation    ${AlertInvalidEmailFormat}