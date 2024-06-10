*** Settings ***
Documentation       Suite description

Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/cart_page.robot
Resource            ../pages/home_page.robot
Resource            ../pages/product_detail_page.robot
Resource            ../pages/checkout_page.robot
Library             DateTime

Test Setup          Start Test Case
Test Teardown       End Test Case


*** Test Cases ***
G-TCCHG1.Login with invalid whatsapp number format
    [Tags]    checkout
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductVirtualSKUForSearch}
    Validate Search Product And Go To PDP    ${ProductVirtualNameForSearch}
    @{productName}    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue}    Get Product Name From Minicart
    &{Arguments}    Create Dictionary
    ...    productName=@{productName}
    ...    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Go To Shopping Cart

    Go To Checkout Page From Shopping Cart
    Input SCV2 Login Phone Number    PhoneNumber=0
    SCV2 Submit Login
    Invalid Login Validation

G-TCCHG3.Add shipping address
    [Tags]    checkout
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductConfigSKUForSearch}
    Validate Search Product And Go To PDP    ${ProductConfigNameForSearch}
    @{productName}    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue}    Get Product Name From Minicart
    &{Arguments}    Create Dictionary
    ...    productName=@{productName}
    ...    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Go To Shopping Cart

    Go To Checkout Page From Shopping Cart
    Input SCV2 Login Phone Number    PhoneNumber=${OtpPhonenumber}
    SCV2 Submit Login

    Select First Item In Verification Method
    ${GetOTP}    Generate SCV2 Password
    Input SCV2 Login OTP    ${GetOTP}

    SCV2 Submit Login
    Wait Until Element Is Visible With Long Time    ${CheckoutPageCountdown}

    Add User Email If Emty    CheckoutEmail=${EmailAddressRegistered}

    ${AddressIsEmty}    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${ButtonAddAddressCheckoutPage}
    ${ShippingRecipient}    Generate Random Keyword
    ${ShippingOtherLabel}    Generate Random Keyword
    IF    ${AddressIsEmty}
        Click Element    ${ButtonAddAddressCheckoutPage}
    ELSE
        Click Element    ${ButtonChangeSelectedAddressCheckoutPage}
    END
        Click Element    ${ButtonAddNewAddressInAddressList}
    Input Address Form
    ...    ${ShippingOtherLabel}
    ...    ${ShippingRecipient}
    ...    ${PhoneNumber}
    ...    ${ShipmentAddressDetail}
    ...    ${ShippingCity}
    ...    ${ShipmentPostalCode}
    ...    ${ShipmentPinLocation}
    Save Address

    Chenge Selected Address
    Save Selected Address
    Wait Until Element Is Visible With Long Time    ${CheckoutPageCountdown}
    Select Shipping Method
    Select Payment Method    ${DropdownVAMidtransMethodItem}
    Submit Place Order
    Midtrans Virtual Account Transaction
    Thankyou page Validation

G-TCCHG5.Change shipping address
    [Tags]    checkout
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductConfigSKUForSearch}
    Validate Search Product And Go To PDP    ${ProductConfigNameForSearch}
    @{productName}    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue}    Get Product Name From Minicart
    &{Arguments}    Create Dictionary
    ...    productName=@{productName}
    ...    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Go To Shopping Cart

    Go To Checkout Page From Shopping Cart
    Input SCV2 Login Phone Number    PhoneNumber=${OtpPhonenumber}


    Select First Item In Verification Method
    ${GetOTP}    Generate SCV2 Password
    Input SCV2 Login OTP    ${GetOTP}

    SCV2 Submit Login
    Wait Until Element Is Visible With Long Time    ${CheckoutPageCountdown}

    Add User Email If Emty    CheckoutEmail=${EmailAddressRegistered}

    # Melakukan Add Adrees jika user belum pernah menambahkan alamat
    ${ShippingRecipient}    Generate Random Keyword
    ${ShippingOtherLabel}    Generate Random Keyword
    Add User Address If Emty
    ...    ${ShippingOtherLabel}
    ...    ${ShippingRecipient}
    ...    ${PhoneNumber}
    ...    ${ShipmentAddressDetail}
    ...    ${ShippingCity}
    ...    ${ShipmentPostalCode}
    ...    ${ShipmentPinLocation}

    # Melakukan pengechekan, jika alamat yang di miliki user kurang dari 2, maka akan melakukan penambahan data alamat
    Wait Until Element Is Visible With Long Time    ${ButtonChangeSelectedAddressCheckoutPage}
    Click Element    ${ButtonChangeSelectedAddressCheckoutPage}
    Count and Add address If Less Than Two

    Chenge Selected Address
    Save Selected Address
    Wait Until Element Is Visible With Long Time    ${CheckoutPageCountdown}
    Select Shipping Method
    Select Payment Method    ${DropdownVAMidtransMethodItem}
    Submit Place Order
    Midtrans Virtual Account Transaction
    Thankyou page Validation


G-TCCHG17.Apply valid coupon code
    [Tags]    checkout
    Log    "Tester Perlu Membuat Promotion Dengan Code yang disimpan pada variable --PromoCode--"
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductConfigSKUForSearch}
    Validate Search Product And Go To PDP    ${ProductConfigNameForSearch}
    @{productName}    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue}    Get Product Name From Minicart
    &{Arguments}    Create Dictionary
    ...    productName=@{productName}
    ...    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Go To Shopping Cart

    Go To Checkout Page From Shopping Cart
    Input SCV2 Login Phone Number    PhoneNumber=${OtpPhonenumber}

    Select First Item In Verification Method
    ${GetOTP}    Generate SCV2 Password
    Input SCV2 Login OTP    ${GetOTP}

    SCV2 Submit Login
    Wait Until Element Is Visible With Long Time    ${CheckoutPageCountdown}

    Add User Email If Emty    CheckoutEmail=${EmailAddressRegistered}
    Select Shipping Method
    Select Payment Method    ${DropdownVAMidtransMethodItem}

    Wait Until Element Is Visible With Long Time    ${ButtonAddPromo}
    Click Element    ${ButtonAddPromo}    
    Input Promo Code    ${PromoCode}
    Select Button Apply Promo

    Validate Message Success Alert Is Visible On Checkout Page


    Submit Place Order
    Midtrans Virtual Account Transaction
    Thankyou page Validation

G-TCCHG25.Successful Checkout Test with simple product using registered account
    [Tags]    Checkout25
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Validate Search Product And Go To PDP    ${ProductSimpleNameForSearch}
     @{productName} =    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=@{productName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Go To Shopping Cart
    Go To Checkout Page From Shopping Cart
    Input SCV2 Login Phone Number    PhoneNumber=${OtpPhonenumber}

    Select First Item In Verification Method
    ${GetOTP}    Generate SCV2 Password
    Input SCV2 Login OTP    ${GetOTP}

    SCV2 Submit Login
    Wait Until Element Is Visible With Long Time    ${CheckoutPageCountdown}

    Add User Email If Emty    CheckoutEmail=${EmailAddressRegistered}

    # Melakukan Add Adrees jika user belum pernah menambahkan alamat
    ${ShippingRecipient}    Generate Random Keyword
    ${ShippingOtherLabel}    Generate Random Keyword
    Add User Address If Emty
    ...    ${ShippingOtherLabel}
    ...    ${ShippingRecipient}
    ...    ${PhoneNumber}
    ...    ${ShipmentAddressDetail}
    ...    ${ShippingCity}
    ...    ${ShipmentPostalCode}
    ...    ${ShipmentPinLocation}

    # Melakukan pengechekan, jika alamat yang di miliki user kurang dari 2, maka akan melakukan penambahan data alamat
    Wait Until Element Is Visible With Long Time    ${ButtonChangeSelectedAddressCheckoutPage}
    Click Element    ${ButtonChangeSelectedAddressCheckoutPage}
    Count and Add address If Less Than Two

    Chenge Selected Address
    Save Selected Address
    Wait Until Element Is Visible With Long Time    ${CheckoutPageCountdown}
    Select Shipping Method
    Select Payment Method    ${EMPTY}
    Submit Place Order
    Midtrans Virtual Account Transaction
    Thankyou page Validation