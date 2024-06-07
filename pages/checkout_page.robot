*** Settings ***
Library         DateTime
Resource        ../base/common.robot
Resource        ../pages/cart_page.robot
Variables       ../resources/locators/scv2_locator.py

*** Variables ***
${DATE_FORMAT}  %d%m%y

*** Keywords ***
Input SCV2 Login Phone Number
    [Arguments]    ${PhoneNumber}
    Wait Until Element Is Visible With Long Time    ${InputPhoneNumberLogin}
    Input Text    ${InputPhoneNumberLogin}    ${PhoneNumber}

SCV2 Submit Login
    Wait Until Element Is Visible With Long Time    ${ButtonCheckoutogInSCV}
    Click Element    ${ButtonCheckoutogInSCV}

Invalid Login Validation
    Wait Until Element Is Visible With Long Time    ${AlertMessageLoginFaild}

Generate SCV2 Password
    ${current_date}=  Get Current Date  result_format=${DATE_FORMAT}
    RETURN  ${current_date}

SCV2 Request OTP
    Wait Until Element Is Visible With Long Time    ${SendWAOTPButton}
    Click Element    ${SendWAOTPButton}

SCV2 Send OTP
    ${CurrentOTPSCV}    Generate SCV2 Password
    Input Text    ${SCVOTPField}    ${CurrentOTPSCV}
    Click Button    ${SCVContinueToCheckout}

SCV Validate All Blank New Address
    Wait Until Element Is Visible With Long Time    ${SCVErrorMessageAddressBlank}