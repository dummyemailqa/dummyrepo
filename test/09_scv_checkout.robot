*** Settings ***
Documentation       Suite description
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/cart_page.robot
Resource            ../pages/home_page.robot
Resource            ../pages/product_detail_page.robot
Resource            ../pages/checkout_page.robot



Test Setup          Start Test Case
# Test Teardown       End Test Case

*** Test Cases ***

G-TCCHG1.Login with invalid whatsapp number format
    [Tags]    checkout
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductVirtualSKUForSearch}
    Validate Search Product And Go To PDP    ${ProductVirtualNameForSearch}
    @{productName} =    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=@{productName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Go To Shopping Cart

    Go To Checkout Page From Shopping Cart
    Input SCV2 Login Phone Number    PhoneNumber=0
    SCV2 Submit Login
    Invalid Login Validation

G-TCCHG5.Change shipping address
    [Tags]    checkout
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductVirtualSKUForSearch}
    Validate Search Product And Go To PDP    ${ProductVirtualNameForSearch}
    @{productName} =    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=@{productName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Go To Shopping Cart

    Go To Checkout Page From Shopping Cart
    Input SCV2 Login Phone Number    PhoneNumber=081234567890
    SCV2 Submit Login

    Select First Item In Verification Method
    ${GetOTP}    Generate SCV2 Password
    Input SCV2 Login OTP    ${GetOTP}

    SCV2 Submit Login
    Wait Until Element Is Visible With Long Time    ${CheckoutPage}

    # Click Button Change Address
    Wait Until Element Is Visible With Long Time    //span[contains(@class,'checkout-address-changeButton')]
    Click Element    //span[contains(@class,'checkout-address-changeButton')]

    # Click First button Change Address In Address List
    Wait Until Element Is Visible With Long Time    //span[contains(@class,'checkout-addressList-editButton')]
    # Click Element    //span[contains(@class,'checkout-addressList-editButton')]
    
    # Input Address Form    ${ShippingOtherLabel}    ${ShippingRecipient}    ${ShipmentAddressDetail}    ${ShipmentPostalCode}
    # Save Address

# G-TCCHG5.Change shipping address
#     [Tags]    checkout
#     Empty the items in MiniCart
#     Search Product by Keyword in Searchbox    ${ProductVirtualSKUForSearch}
#     Validate Search Product And Go To PDP    ${ProductVirtualNameForSearch}
#     @{productName} =    Add To Cart    Qty=1
#     Alert Success Validation
#     Open Minicart
#     @{MinicartProductNameValue} =    Get Product Name From Minicart
#     &{Arguments} =    Create Dictionary    productName=@{productName}    MinicartProductNameValue=@{MinicartProductNameValue}
#     Validate The Similarity Of Item Added To Cart    &{Arguments}
#     Go To Shopping Cart

#     Go To Checkout Page From Shopping Cart
#     Input SCV2 Login Phone Number    PhoneNumber=081234567890
#     SCV2 Submit Login

#     Select First Item In Verification Method
#     ${GetOTP}    Generate SCV2 Password
#     Input SCV2 Login OTP    ${GetOTP}

#     SCV2 Submit Login
#     Wait Until Element Is Visible With Long Time    ${CheckoutPage}

#     # Click Button Change Address
#     Wait Until Element Is Visible With Long Time    //span[contains(@class,'checkout-address-changeButton')]
#     Click Element    //span[contains(@class,'checkout-address-changeButton')]

#     # Click First button Change Address In Address List
#     ${HaveMoreAddress}    Wait Until Element Is Visible With Long Time    (//input[@name='select-address'])[2]
#     IF  not ${HaveMoreAddress}
#         # Click Element    //button[@id='checkout-address-addButton']

#         # #add new address
#         # Wait Until Element Is Visible With Long Time    //button[@id='checkout-address-addButton']
#         # Input Address Form    ${ShippingOtherLabel}    ${ShippingRecipient}    ${ShipmentAddressDetail}    ${ShippingCity}    ${ShipmentPostalCode}
#         Log    masuk 1
#     ELSE
#         Log    masuk 2
#     END
    