*** Settings ***
Library     SeleniumLibrary
Library     String
Variables   ../resources/data/testdata.py
Variables    ../resources/locators/home_locator.py
Resource    ../base/common.robot

*** Keywords ***
Go To Home Page 
    Go To                                                   ${URLWEB}   

End Test Case
    Go To My Account Page
    ${failed} =  Register Keyword To Run On Failure  NONE
    ${present} =    Run Keyword and Return Status   Wait Until Element Is Visible   ${UserLoggedInIcon}
    Register Keyword To Run On Failure  ${failed}
    IF  ${present}
        Logout Account
    END
    Delete All Cookies
    Go to Home Page

Go To My Account Page
    Go To                                                   ${URLAccount}

Logout Account
    Wait Until Element Is Visible           ${UserLoggedInIcon}
    Click Element       ${UserLoggedInIcon}
    Wait Until Element Is Enabled   ${ButtonSignOut}
    Click Element   ${ButtonSignOut}
    Wait Until Element Is Not Visible    ${UserLoggedInIcon}

Search Product Not Match 
    [Arguments]    ${Keyword}    ${Result}
    Fail                                                    Data Nama Product '${Result}' tidak sesuai dengan katakunci : ${Keyword}

Alert Visible Validation
   [Arguments]                                              ${AlertMessage}
    Wait Until Element Is Visible With Long Time            ${AlertMessage}

Generate Random Email
    ${randomString}=    Generate Random String              8                                   [LOWER]
    ${randomEmail}=     Set Variable                        ${randomString}@gmail.com
    RETURN                                                  ${randomEmail}

Scroll Down To Element
    [Arguments]  ${locator}
    ${x}=        Get Horizontal Position  ${locator}
    ${y}=        Get Vertical Position    ${locator}
    Execute Javascript  window.scrollTo(${x}, ${y}-100)

Clear Text Field
    [Arguments]    ${Element}
    ${OS}=    Evaluate    platform.system()    platform
    IF  '${OS}'=="Darwin"
        press keys    ${Element}    COMMAND+a  BACKSPACE
    ELSE
        press keys    ${Element}    CTRL+a+BACKSPACE
    END

