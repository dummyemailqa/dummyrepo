*** Settings ***
Library  DateTime
Resource        ../base/common.robot
Resource        ../pages/cart_page.robot

*** Variables ***
${DATE_FORMAT}  %d%m%y

*** Keywords ***   
Input SCV2 Login Phone Number
    [Arguments]    ${PhoneNumber}
    Wait Until Element Is Visible With Long Time    ${InputPhoneNumberLogin}
    Input Text    ${InputPhoneNumberLogin}    ${PhoneNumber}

Generate SCV2 Password
    ${current_date}=  Get Current Date  result_format=${DATE_FORMAT}
    [Return]  ${current_date}

Input SCV2 Login OTP
    [Arguments]    ${OTP}
    Wait Until Element Is Visible With Long Time    ${InputOTPLogin}
    Input Text    ${InputOTPLogin}    ${OTP}

Invalid Login Validation
    Wait Until Element Is Visible With Long Time    ${AlertMessageLoginFaild}

SCV2 Submit Login
    Wait Until Element Is Visible With Long Time    ${ButtonCheckoutogInSCV}
    Click Element    ${ButtonCheckoutogInSCV}

Select Verification Method
    Wait Until Element Is Visible With Long Time    ${OtpVerificationMethod}
    Click Element    ${OtpVerificationMethod}