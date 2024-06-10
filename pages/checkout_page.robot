*** Settings ***
Library  DateTime
Resource        ../base/common.robot
Resource        ../pages/cart_page.robot
Variables       ../resources/locators/scv2_locator.py

*** Keywords ***
Input SCV2 Login Phone Number
    [Arguments]    ${PhoneNumber}
    Wait Until Element Is Visible With Long Time    ${InputPhoneNumberLogin}
    Input Text    ${InputPhoneNumberLogin}    ${PhoneNumber}
    Click Button    //button[@id='checkout-login-continueButton']

SCV2 Submit Login
    Wait Until Element Is Visible With Long Time    ${ButtonCheckoutogInSCV}
    Click Element    ${ButtonCheckoutogInSCV}

OTP Whatsapp Login for Dummy Phone Number SCV2 
    ${today}    Get Current Date
    ${formatted_date}    Convert Date    ${today}    result_format=%d%m%y
    Wait Until Element Is Visible    locator
    Click Element  //*div[@class='MuiDialogContent-root jss7']/div[@class='MuiListItem-button']
    Input Text    //div[@id='checkout-loginPhoneNumber-textField']    ${formatted_date}

Invalid Login Validation
    Wait Until Element Is Visible With Long Time    ${AlertMessageLoginFaild}

Select First Item In Verification Method
    Wait Until Element Is Visible With Long Time    ${FirstOtpVerificationMethod}
    Click Element    ${FirstOtpVerificationMethod}