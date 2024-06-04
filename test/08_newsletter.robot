*** Settings ***
Documentation       Suite description
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/newsletter_page.robot
Resource            ../pages/login_page.robot
Resource            ../pages/my_account_page.robot


Test Setup          Start Test Case
Test Teardown       End Test Case

*** Test Cases ***    
TCNL1.Customer subscribes to newsletter
    [Tags]    newsletter
    Wait Until Element Is Visible With Long Time       ${SearchBox}
    ${SubcribeEmail}    Generate Random Email
    Input Email For Subcribe Newsletter                ${SubcribeEmail}
    Submit Subcribe Newsletter
    Validate Message Success Alert Is Visible
    
TCNL2.1.Customer subscribes to newsletter with already subscribed email
    [Tags]    newsletter
    Login User
    To Newsletter Subscriptions Page
    Subcribe Newsletter Subscriptions
    Go To Home Page
    Input Email For Subcribe Newsletter                ${EmailAddressRegistered}
    Submit Subcribe Newsletter
    Validate Message Error Alert Is Visible

TCNL2.2 Customer subscribes to newsletter with invalid email
    [Tags]    newsletter
    ${InvalidEmail} =     Generate Random Invalid Email
    Input Email For Subcribe Newsletter    ${InvalidEmail}
    Click Element    ${ButtonSubmitSubcribeNewsletter}
    Validate Popup Fail Alert Is Visible    ${AllertMessageErrorNewsletter}
