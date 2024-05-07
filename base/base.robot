*** Settings ***
Library     SeleniumLibrary
Library     String
Variables   ../resources/data/testdata.py
Variables    ../resources/locators/home_locator.py

*** Keywords ***
End Test Case
    Go To My Account Page
    ${failed} =  Register Keyword To Run On Failure  NONE
    ${present} =    Run Keyword and Return Status   Wait Until Element Is Visible   ${UserLoggedInIcon}
    Register Keyword To Run On Failure  ${failed}
    IF  ${present}
        Logout Account
    END
    Delete All Cookies

Go To My Account Page
    Go To                                                   ${URLAccount}

Logout Account
    Wait Until Element Is Visible   ${UserLoggedInIcon}
    Click Element   ${UserLoggedInIcon}
    Wait Until Element Is Enabled   ${ButtonSignOut}
    Click Element   ${ButtonSignOut}
    Wait Until Element Is Not Visible    ${UserLoggedInIcon}