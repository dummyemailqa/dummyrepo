*** Settings ***
Library  DateTime
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

Select First Item In Verification Method
    Wait Until Element Is Visible With Long Time    ${FirstOtpVerificationMethod}
    Click Element    ${FirstOtpVerificationMethod}

Generate SCV2 Password
    ${current_date}=  Get Current Date  result_format=${DATE_FORMAT}
    RETURN  ${current_date}

Input SCV2 Login OTP
    [Arguments]    ${OTP}
    Wait Until Element Is Visible With Long Time    ${InputOTPLogin}
    Input Text    ${InputOTPLogin}    ${OTP}

Input Address Form
    [Arguments]    ${ShippingOtherLabel}    ${ShippingRecipient}    ${ShipmentAddressDetail}    ${ShippingCity}    ${ShipmentPostalCode}
    Wait Until Element Is Visible With Long Time    //button[@id='checkout-address-saveButton']
    
    Click Element    //div[@id='address_label']
    Wait Until Element Is Visible With Long Time    //ul[@role='listbox']
    Click Element    //ul[@role='listbox']//li[last()]
    
    ${OtherLabelIsVisible}    Run Keyword And Return Status        Wait Until Element Is Visible    //input[@id='checkout-addressLabelOther-textField']
    IF  ${OtherLabelIsVisible}    
        Clear Text Field    //input[@id='checkout-addressLabelOther-textField']
        Input Text    //input[@id='checkout-addressLabelOther-textField']    ${ShippingOtherLabel}
    END

    Clear Text Field    //input[@id='checkout-addressRecipient-textField']
    Input Text    //input[@id='checkout-addressRecipient-textField']    ${ShippingRecipient}

    Clear Text Field    //input[@id='checkout-addressDetail-textField']
    Input Text    //input[@id='checkout-addressDetail-textField']    ${ShipmentAddressDetail}

    Clear Text Field    //input[@id='checkout-addressCity-autoCompleteField']
    Input Text    //input[@id='checkout-addressCity-autoCompleteField']    ${ShippingCity}
    Wait Until Element Is Visible With Long Time    //li[@id='checkout-addressCity-autoCompleteField-option-0']
    Click Element    //li[@id='checkout-addressCity-autoCompleteField-option-0']

    Clear Text Field    //input[@id='checkout-addressPostalCode-textField']
    Input Text    //input[@id='checkout-addressPostalCode-textField']    ${ShipmentPostalCode}

Save Address
    Click Element    //input[@id='checkout-addressPostalCode-textField']
    Wait Until Element Is Not Visible With Long Time    //input[@id='checkout-addressPostalCode-textField']

Close Address List
    Wait Until Element Is Visible With Long Time    //div[contains(@class,'row btn-close')]//button
    Click Element    //div[contains(@class,'row btn-close')]//button