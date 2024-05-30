*** Settings ***
Documentation       Suite description
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/newsletter_page.robot

Test Setup          Start Test Case
Test Teardown       End Test Case

*** Test Cases ***    
TCNL1.Customer subscribes to newsletter
    [Tags]    newsletter
    Wait Until Element Is Visible With Long Time    ${SearchBox}
    ${SubcribeEmail}    Generate Random Email
    Input Email For Subcribe Newsletter    ${SubcribeEmail}
    Submit Subcribe Newsletter
    Validate Message Success Alert Is Visible
    