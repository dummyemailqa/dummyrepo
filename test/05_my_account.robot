*** Settings ***
Documentation       Suite description

Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/login_page.robot
Resource            ../pages/my_account_page.robot


Test Setup          Start Test Case
Test Teardown       End Test Case


*** Test Cases ***

L-TCMy1.Logged In User Can Edit Information
    To Login Page
    Input Login Form    ${EmailAddressRegistered}    ${Password}
    Submit Form Login
    My Account Page Validation    ${EmailAddressRegistered}
    To Account Information
    ${NewPhoneNumber}=    Generate Random Phonenumber
    ${NewWANumber}=    Generate Random Phonenumber
    Change Information        ${EditName}    ${EditLastName}   ${NewPhoneNumber}    ${NewWANumber}
    Save Information
    Alert Success Validation