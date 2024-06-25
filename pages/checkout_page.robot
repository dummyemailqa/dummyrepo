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
    Click Button    ${ButtonCheckoutogInSCV}

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

SCV2 Request OTP
    Wait Until Element Is Visible With Long Time    ${SendWAOTPButton}
    Click Element    ${SendWAOTPButton}

SCV2 Send OTP
    ${CurrentOTPSCV}    Generate SCV2 Password
    Input Text    ${SCVOTPField}    ${CurrentOTPSCV}
    Click Button    ${SCVContinueToCheckout}

SCV Validate Blank Field New Address
    Wait Until Element Is Visible With Long Time    ${SCVErrorMessageAddressBlank}

SCV Validate Blank City New Address
    Wait Until Element Is Visible With Long Time    ${SCVCityBlank}

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
    ${ListItemIsVisible}    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${ListAddressCityFirstItem}
    IF  '${ShippingCity}'!='${EMPTY}'
        IF  ${ListItemIsVisible}
            Click Element    ${ListAddressCityFirstItem} 
        ELSE
            Click Element    ${SCVButtonAddressList}
            Wait Until Element Is Visible    ${ListAddressCityFirstItem}
            Click Element    ${ListAddressCityFirstItem} 
        END
    END

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

Change Selected Address
    Wait Until Element Is Visible With Long Time    ${ButtonAddNewAddressInAddressList}
    ${first_selected}=    Run Keyword And Return Status    Checkbox Should Be Selected    ${RadioButtonSelectFirstAddressInList}
    ${second_selected}=    Run Keyword And Return Status    Checkbox Should Be Selected    ${RadioButtonSelectSecondAddressInList}
    IF    ${first_selected}
        Click Element    ${RadioButtonSelectSecondAddressInList}
    ELSE IF    ${second_selected}
        Click Element    ${RadioButtonSelectFirstAddressInList}
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

Select Or Unselect Insurance shipping
    [Arguments]    ${InsuranceStatus}
    Wait Until Element Is Visible With Long Time    ${ButtonSelectShippingMethod}
    Click Element    ${ButtonSelectShippingMethod}

    Wait Until Element Is Visible With Long Time    ${DropdownShippingMethodItem}
    ${CurarentInsuranceStatus}=    Get Element Attribute    ${CheckboxShippingInsurance}    value
    Log To Console     ${CurarentInsuranceStatus}
    IF    '${InsuranceStatus}' == 'Select'
        Run Keyword If    '${CurarentInsuranceStatus}' == 'false'    Click Element    ${CheckboxShippingInsurance}
    ELSE IF    '${InsuranceStatus}' == 'Unselect'
        Run Keyword If    '${CurarentInsuranceStatus}' == 'true'    Click Element    ${CheckboxShippingInsurance}
    END
    Click Element    ${CloseFormSelectShippingMethod}

Select Or Unselect Insurance shipping Validation
    [Arguments]    ${InsuranceStatus}
    Scroll Down To Element    ${ButtonCheckoutPlaceOrder}
    Wait Until Element Is Visible in 10s    ${ButtonCheckoutPlaceOrder}
    ${InsuranceBillingVisibleId}    Run Keyword And Return Status    Wait Until Element Is Visible    ${LabelInsuranceBillingId}
    ${InsuranceBillingVisibleEn}    Run Keyword And Return Status    Wait Until Element Is Visible    ${LabelInsuranceBillingEn}

    IF    '${InsuranceStatus}' == 'Select'  
        IF  ${InsuranceBillingVisibleId}
            RETURN    Pass
        ELSE IF    ${InsuranceBillingVisibleId}
            RETURN    Pass
        ELSE
            Fail    Insurance shipping not visible
        END
    ELSE IF    '${InsuranceStatus}' == 'Unselect'
        IF  not ${InsuranceBillingVisibleId}
            RETURN    Pass
        ELSE IF  not ${InsuranceBillingVisibleId}
            RETURN    Pass
        ELSE
            Fail    Insurance shipping Is visible
        END
    END

Select Payment Method
    [Arguments]    ${PaymentMethod}
    Wait Until Element Is Visible With Long Time    ${ButtonSelectPaymentMethod}
    Click Element    ${ButtonSelectPaymentMethod}

    Wait Until Element Is Visible With Long Time    ${PaymentMethod}
    Click Element    ${PaymentMethod}

Select Promotion
    Wait Until Element Is Visible With Long Time    ${AddAvailPromo}
    Click Element    ${AddAvailPromo}

Invalid Promo Code Validation
    Wait Until Element Is Visible With Long Time    ${AllertMessage}
    Wait Until Element Is Not Visible With Long Time    ${AllertMessage}
    Click Element    ${ButtonClosePromo}

Submit Place Order
    Wait Until Element Is Visible With Long Time    ${LabelSelectPaymentMethod}
    Scroll Down To Element    ${ButtonCheckoutPlaceOrder}
    Click Element    ${ButtonCheckoutPlaceOrder}

Submit Place Order Zero Subtotal
    Wait Until Element Is Not Visible With Long Time    ${LabelSelectPaymentMethod}
    Scroll Down To Element    ${ButtonCheckoutPlaceOrder}
    Click Element    ${ButtonCheckoutPlaceOrder}

Midtrans Virtual Account Transaction
    Select Frame    ${MidtransFrame}
    Wait Until Page Contains Element    ${MidtransPopup}    10
    Click Element    ${CloseMitransPopup}
    Unselect Frame

Thankyou page Validation
    Wait Until Element Is Visible With Long Time    ${ThankyouPageHeader}

Continue Shopping
    Wait Until Element Is Visible With Long Time    ${ButtonContinueShopping}
    Click Element    ${ButtonContinueShopping}

SCV Validate Blank Pinpoint New Address
    Wait Until Element Is Visible With Long Time    ${SCVPinpointBlank}

Validate Blank Address Form Field
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
    Wait Until Element Is Not Visible    ${ListAddressCityFirstItem}

    Clear Text Field    ${InputAddressPostalCode}
    Input Text    ${InputAddressPostalCode}    ${ShipmentPostalCode}

    Click Element    ${ButtonToPinpoinLocationForm}
    Wait Until Element Is Visible With Long Time    ${InputGoogleMapSearchPinPointLocation}
    Clear Text Field    ${InputGoogleMapSearchPinPointLocation}
    Input Text    ${InputGoogleMapSearchPinPointLocation}    ${PinLocation}
    Press Keys    ${InputGoogleMapSearchPinPointLocation}    ARROW_DOWN
    Press Keys    ${InputGoogleMapSearchPinPointLocation}    ENTER
    Click Element    ${ButtonSavePinPointLocation}

Validate Blank Pinpoint
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

Input Promo Code
    [Arguments]    ${PromoCode}
    Wait Until Element Is Visible With Long Time    ${InputPromoCode}
    Clear Text Field    ${InputPromoCode}
    Input Text    ${InputPromoCode}    ${PromoCode}

Select Button Apply Promo
    Wait Until Element Is Enabled    ${ButtonApplyPromo}
    Click Element    ${ButtonApplyPromo}

Validate Message Success Alert Is Visible On Checkout Page
    Wait Until Element Is Visible With Long Time    ${CheckoutSuccessAllert}
    Wait Until Element Is Not Visible With Long Time    ${CheckoutSuccessAllert}

Select Billing Address Same As Shipping Address
    ${BillingAddressSameAsShippingAddress}    Run Keyword And Return Status      Wait Until Element Is Visible    ${ButtonChangeBillingAddress}    timeout=10
    Run Keyword If    ${BillingAddressSameAsShippingAddress}    Click Element    ${CheckboxBillingAddressSameAsShippingAddress}

UnSelect Billing Address Same As Shipping Address
    ${Status}=     Run Keyword And Return Status                Checkbox Should Be Selected    ${CheckboxBillingAddressSameAsShippingAddress}
    IF    ${Status}    
        Click Element    ${CheckboxBillingAddressSameAsShippingAddress}
        Scroll Down To Element    ${ButtonChangeBillingAddress}
        Wait Until Element Is Visible With Long Time    ${ButtonChangeBillingAddress}
    END

Adding New a Billing Address
    Click Element    ${ButtonChangeBillingAddress}
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
    Close Address List

Selecting or Adding New a Billing Address
    Click Element    ${ButtonChangeBillingAddress}
    Count and Add address If Less Than Two
    Change Selected Address
    Save Selected Address

Login at the Checkout Page for Guest Users
    Input SCV2 Login Phone Number    PhoneNumber=${OtpPhonenumber}
    Select First Item In Verification Method
    ${GetOTP}    Generate SCV2 Password
    Input SCV2 Login OTP    ${GetOTP}
    SCV2 Submit Login
    Wait Until Element Is Visible With Long Time    ${CheckoutPageCountdown}

Submit Giftcard Code
    [Arguments]    ${GiftCard}
    Input Text    ${GiftCardInput}    ${GiftCard}
    Click Element    ${GiftCardPasangButton}
    Wait Until Element Is Not Visible    ${GiftCardLoader}

Validate Grandtotal Is Zero
    ${GrandTotalText}    Get Text    ${GrandTotalInSummary}
    ${GrandTotalAfterPromo}    Convert Price With String to Integer    ${GrandTotalText}
    Should Be Equal As Integers    ${GrandTotalAfterPromo}    0

Get Grand Total And Convert To Integer
    ${GrandTotalText}    Get Text    ${GrandTotalInSummary}
    ${GrandTotal}    Convert Price With String to Integer    ${GrandTotalText}
    RETURN    ${GrandTotal}

Remove Used Promo
    Click Element    ${ButtonAddPromo}
    Wait Until Element Is Visible    ${CheckedPromo}
    Click Element    ${CheckedPromo}
    Wait Until Element Is Enabled    ${ButtonRemovePromo}
    Click Element    ${ButtonRemovePromo}

Select Promo From Promotion List
    Scroll Down To Element    ${ButtonAddPromo}
    Click Element    ${ButtonAddPromo}
    Wait Until Element Is Visible With Long Time    ${CheckBoxFirstExistingPromo}
    ${first_selected}=    Run Keyword And Return Status    Checkbox Should Be Selected    ${CheckBoxFirstExistingPromo}
    IF    ${first_selected}
        Click Element    ${CheckBoxSecondExistingPromo}
    ELSE
        Click Element    ${CheckBoxFirstExistingPromo}
    END  

Select Button Apply Existing Promotion
    Wait Until Element Is Visible    ${ButtonApplyExistingPromo}
    Click Element    ${ButtonApplyExistingPromo}

Input Recipient Form
    [Arguments]
    ...    ${PickUpRecipientName}
    ...    ${PickUpRecipientPhone}
    ...    ${PickUpRecipientEmail}
    Wait Until Element Is Visible With Long Time    ${PickUpButtonSaveRecipient}
    Clear Text Field    ${PickUpRecipientNameField}
    Input Text    ${PickUpRecipientNameField}    ${PickUpRecipientName}
    Clear Text Field    ${PickUpRecipientPhoneField}
    Input Text    ${PickUpRecipientPhoneField}    ${PickUpRecipientPhone}
    Clear Text Field    ${PickUpRecipientEmailField}
    Input Text    ${PickUpRecipientEmailField}    ${PickUpRecipientEmail}
    Click Element    ${PickUpButtonSaveRecipient}

Validate Pickup In Store Recipient Blanks
    Wait Until Element Is Visible With Long Time    ${PickUpErrorMessageAlert}

Go To Recipient Form
    ${PickUpHasNoAddress}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ButtonPickUpNewRecipient}
    IF  ${PickUpHasNoAddress}
        Click Element    ${ButtonPickUpNewRecipient} 
    ELSE
        Wait Until Element Is Visible With Long Time    ${ButtonUbahRecipient}
        Click Element    ${ButtonUbahRecipient}
    END

Select Pickup In Store Delivery Method
    Wait Until Element Is Visible With Long Time    ${ButtonPickupInStore}
    Click Element    ${ButtonPickupInStore}

Select Existing Giftcard Code
    Wait Until Element Is Visible    ${ButtonExistingGiftCard}
    Click Element    ${ButtonExistingGiftCard}
    Wait Until Element Is Not Visible    ${GiftCardLoader}