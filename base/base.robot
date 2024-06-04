*** Settings ***
Library         SeleniumLibrary
Library         String
Variables       ../resources/data/testdata.py
Variables       ../resources/locators/home_locator.py
Resource        ../base/common.robot

*** Keywords ***
Go To Home Page
    Go To    ${URLWEB}

End Test Case
    Go To My Account Page
    ${failed}=    Register Keyword To Run On Failure    NONE
    ${present}=    Run Keyword and Return Status    Wait Until Element Is Visible    ${UserLoggedInIcon}
    Register Keyword To Run On Failure    ${failed}
    IF    ${present}    Logout Account
    Delete All Cookies
    Go to Home Page

Go To My Account Page
    Go To    ${URLAccount}

Logout Account
    Wait Until Element Is Visible    ${UserLoggedInIcon}
    Click Element    ${UserLoggedInIcon}
    Wait Until Element Is Enabled    ${CustomerMenuSignOut}
    Click Element    ${CustomerMenuSignOut}
    Wait Until Element Is Not Visible    ${UserLoggedInIcon}

Search Product Not Match
    [Arguments]    ${Keyword}    ${Result}
    Fail    Data Nama Product '${Result}' tidak sesuai dengan katakunci : ${Keyword}

Alert Visible Validation
    [Arguments]    ${AlertMessage}
    Wait Until Element Is Visible With Long Time    ${AlertMessage}

Generate Random Email
    ${randomString}=    Generate Random String    8    [LOWER]
    ${randomEmail}=    Set Variable    ${randomString}@gmail.com
    RETURN    ${randomEmail}

Scroll Down To Element
    [Arguments]    ${locator}
    ${x}=    Get Horizontal Position    ${locator}
    ${y}=    Get Vertical Position    ${locator}
    Execute Javascript    window.scrollTo(${x}, ${y}-100)

Validate Similarity Of 2 Arguments
    [Arguments]    ${Argument1}    ${Argument2}
    ${Argument1}=    Convert To Lower Case    ${Argument1}
    ${Argument2}=    Convert To Lower Case    ${Argument2}
    ${ValidateSimilarity}=    Run Keyword And Return Status    Should Be Equal    ${Argument1}    ${Argument2}
    RETURN    ${ValidateSimilarity}

Clear Text Field
    [Arguments]    ${Element}
    ${OS}=    Evaluate    platform.system()    platform
    IF    '${OS}'=="Darwin"
        press keys    ${Element}    COMMAND+a    BACKSPACE
    ELSE
        press keys    ${Element}    CTRL+a+BACKSPACE
    END

Validate Popup Fail Alert Is Visible
# digunakan untuk alert Tooltip seperti https://prnt.sc/5tKzCYCVlSkd
    [Arguments]    ${elementjs}
    ${is_valid}=    Execute JavaScript    return window.document.querySelector("${elementjs}").checkValidity();
    IF    ${is_valid}    Fail    msg=Alert Message Not Showing

Validate Message Error Alert Is Visible
# digunakan untuk alert Message seperti https://prnt.sc/QezUR0wVWTcU
    Wait Until Element Is Visible With Long Time    ${MessageErrorAlert}

Validate Message Success Alert Is Visible
# digunakan untuk alert Message seperti https://prnt.sc/rLZil7KvCoDv
    Wait Until Element Is Visible With Long Time    ${MessageSuccessAlert}
    Click Element    ${CloseMessageSuccessAlertButton}
    Wait Until Element Is Not Visible    ${MessageSuccessAlert}

Generate Random PhoneNumber
    ${randomString}=                    Generate Random String      10   [NUMBERS]
    ${PhoneNumber}=                     Set Variable                ${randomString}
    RETURN                            ${PhoneNumber}

Generate Random Name
    ${randomString}=                    Generate Random String      5   [LETTERS]
    ${Name}=                     Set Variable                ${randomString}
    RETURN                            ${SPACE}${Name}

Generate Random Comment
    ${randomString}=                Generate Random String      50   [LETTERS]
    ${Comment}=                     Set Variable                ${randomString}
    RETURN                          ${Comment}

Generate Random Invalid Email
    ${randomString}=    Generate Random String    8    [LOWER]
    ${randomEmail}=    Set Variable    ${randomString}gmail.com
    RETURN    ${randomEmail}