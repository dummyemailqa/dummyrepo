*** Settings ***
Documentation       Suite description
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/cart_page.robot
Resource            ../pages/home_page.robot
Resource            ../pages/product_detail_page.robot
Resource            ../pages/checkout_page.robot


Test Setup          Start Test Case
Test Teardown       End Test Case

*** Test Cases ***
G-TCCHR1.Customer proceed to checkout page
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

    Select Verification Method
    ${GetOTP}    Generate SCV2 Password
    Input SCV2 Login OTP    ${GetOTP}

    SCV2 Submit Login
    Wait Until Element Is Visible With Long Time    ${CheckoutPage}
