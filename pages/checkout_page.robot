*** Settings ***
Library         DateTime
Resource        ../base/common.robot
Resource        ../pages/cart_page.robot
Variables       ../resources/locators/scv2_locator.py


*** Variables ***
${DATE_FORMAT}      %d%m%y


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
    ${current_date}    Get Current Date    result_format=${DATE_FORMAT}
    RETURN    ${current_date}

Input SCV2 Login OTP
    [Arguments]    ${OTP}
    Wait Until Element Is Visible With Long Time    ${InputOTPLogin}
    Input Text    ${InputOTPLogin}    ${OTP}

Input Address Form
    [Arguments]
    ...    ${ShippingOtherLabel}
    ...    ${ShippingRecipient}
    ...    ${AddressPhoneNumber}
    ...    ${ShipmentAddressDetail}
    ...    ${ShippingCity}
    ...    ${ShipmentPostalCode}
    ...    ${PinLocation}
    Wait Until Element Is Visible With Long Time    ${ButtonSaveAddressInAddressForm}

    Clear Text Field    ${InputaddressRecipient}
    Input Text    ${InputaddressRecipient}    ${ShippingRecipient}

    ${AddressLabelIsVisible}    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${DropdownAddressLabel}
    IF    ${AddressLabelIsVisible}
        Wait Until Element Is Visible With Long Time    ${DropdownAddressLabel}
        Click Element    ${DropdownAddressLabel}
        Wait Until Element Is Visible With Long Time    ${DropdownAddressLabelList}
        Click Element    ${DropdownAddressLabelListLastItem}

        ${OtherLabelIsVisible}    Run Keyword And Return Status
        ...    Wait Until Element Is Visible
        ...    ${InputAddressLabel}
        IF    ${OtherLabelIsVisible}
            Clear Text Field    ${InputAddressLabel}
            Input Text    ${InputAddressLabel}    ${ShippingOtherLabel}
        END
    END
    Clear Text Field    ${InputAddressPhoneNumber}
    Input Text    ${InputAddressPhoneNumber}    ${AddressPhoneNumber}

    Clear Text Field    ${InputAddressDetail}
    Input Text    ${InputAddressDetail}    ${ShipmentAddressDetail}

    Clear Text Field    ${InputAddressCity}
    Input Text    ${InputAddressCity}    ${ShippingCity}
    Wait Until Element Is Visible With Long Time    ${ListAddressCityFirstItem}
    Click Element    ${ListAddressCityFirstItem}

    Clear Text Field    ${InputAddressPostalCode}
    Input Text    ${InputAddressPostalCode}    ${ShipmentPostalCode}

    Click Element    ${ButtonToPinpoinLocationForm}
    Wait Until Element Is Visible With Long Time    ${InputGoogleMapSearchPinPointLocation}
    Clear Text Field    ${InputGoogleMapSearchPinPointLocation}
    Input Text    ${InputGoogleMapSearchPinPointLocation}    ${PinLocation}
    Press Keys    ${InputGoogleMapSearchPinPointLocation}    ARROW_DOWN
    Press Keys    ${InputGoogleMapSearchPinPointLocation}    ENTER
    Click Element    ${ButtonSavePinPointLocation}

Save Address
    Wait Until Element Is Visible With Long Time    ${ButtonSaveAddressInAddressForm}
    Click Element    ${ButtonSaveAddressInAddressForm}

Close Address List
    Wait Until Element Is Visible With Long Time    ${ButtonCloseAddressList}
    Click Element    ${ButtonCloseAddressList}

# Hanya digunakan untuk TC G-TCCHG5

Count and Add address If Less Than Two
    Wait Until Element Is Visible With Long Time    ${ButtonSaveSelectedAddress}
    ${total_count}    Get Element Count    ${ItemInAddressList}
    WHILE    ${total_count} < 2
        Wait Until Element Is Visible With Long Time    ${ButtonAddNewAddressInAddressList}
        Click Element    ${ButtonAddNewAddressInAddressList}
        ${ShippingRecipient}    Generate Random Keyword
        ${ShippingOtherLabel}    Generate Random Keyword
        Input Address Form
        ...    ${ShippingOtherLabel}
        ...    ${ShippingRecipient}
        ...    ${PhoneNumber}
        ...    ${ShipmentAddressDetail}
        ...    ${ShippingCity}
        ...    ${ShipmentPostalCode}
        ...    ${ShipmentPinLocation}
        Save Address
        Wait Until Element Is Visible With Long Time    ${ButtonSaveSelectedAddress}
        ${total_count}    Get Element Count    ${ItemInAddressList}
    END

Add User Email If Emty
    [Arguments]    ${CheckoutEmail}
    ${EmailAddressIsEmty}    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    locator=${ValidateEmailAddressIsEmty}
    ...    timeout=10
    IF    ${EmailAddressIsEmty}
        Input Text    ${InputEmailCheckoutPage}    ${CheckoutEmail}
    END

Add User Address If Emty
    [Arguments]
    ...    ${ShippingOtherLabel}
    ...    ${ShippingRecipient}
    ...    ${AddressPhoneNumber}
    ...    ${ShipmentAddressDetail}
    ...    ${ShippingCity}
    ...    ${ShipmentPostalCode}
    ...    ${PinLocation}
    ${AddressIsEmty}    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${ButtonAddAddressCheckoutPage}
    IF    ${AddressIsEmty}
        Click Element    ${ButtonAddAddressCheckoutPage}
        Input Address Form
        ...    ${ShippingOtherLabel}
        ...    ${ShippingRecipient}
        ...    ${AddressPhoneNumber}
        ...    ${ShipmentAddressDetail}
        ...    ${ShippingCity}
        ...    ${ShipmentPostalCode}
        ...    ${PinLocation}
        Save Address
    END

Chenge Selected Address
    Wait Until Element Is Visible With Long Time    ${ButtonAddNewAddressInAddressList}
    ${FistAddressIsSelected}    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${FirstItemInAddresListIsChecked}
    ...    10
    IF    ${FistAddressIsSelected}
        Click Element    ${RadioButtonSelectSecondAddressInList}
    ELSE
        Click Element    ${RadioButtonSelectFirstAddressInList}
    END

Save Selected Address
    Wait Until Element Is Visible With Long Time    ${ButtonSaveSelectedAddress}
    Click Element    ${ButtonSaveSelectedAddress}

Select Shipping Method
    Wait Until Element Is Visible With Long Time    ${ButtonSelectShippingMethod}
    Click Element    ${ButtonSelectShippingMethod}

    Wait Until Element Is Visible With Long Time    ${DropdownShippingMethodItem}
    Click Element    ${DropdownShippingMethodItem}

Select Payment Method
    [Arguments]    ${PaymentMethod}
    Wait Until Element Is Visible With Long Time    ${ButtonSelectPaymentMethod}
    Click Element    ${ButtonSelectPaymentMethod}

    Wait Until Element Is Visible With Long Time    ${PaymentMethod}
    Click Element    ${PaymentMethod}

Submit Place Order
    Wait Until Element Is Visible With Long Time    ${LabelSelectPaymentMethod}
    Scroll Down To Element    ${ButtonCheckoutPlaceOrder}
    Click Element    ${ButtonCheckoutPlaceOrder}

Midtrans Virtual Account Transaction
    Select Frame    ${MidtransFrame}
    Wait Until Page Contains Element    ${MidtransPopup}    10
    Click Element    ${CloseMitransPopup}
    Unselect Frame

Tankyou page Validation
    Wait Until Element Is Visible With Long Time    ${ThankyouPageHeader}
