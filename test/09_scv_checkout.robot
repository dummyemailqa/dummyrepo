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

TCSC1.Customers can access the shopping cart page
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

    Wait Until Element Is Visible    ${ShoppingCartTotalPrice}
    ${PriceInShoppingCart}    Get Text    ${ShoppingCartTotalPrice}
    ${PriceShoppingCartInt}    Convert Price String To Integer    ${PriceInShoppingCart}
    Click Button    ${ButtonIncrease}
    Wait Until Element Is Not Visible With Long Time  ${ShoppingCartLoader}
    Wait Until Element Is Visible    ${ShoppingCartTotalPrice}
    ${PriceInShoppingCart}    Get Text    ${ShoppingCartTotalPrice}
    ${PriceShoppingCartIntIncrement}    Convert Price String To Integer    ${PriceInShoppingCart}
    Should Be True    ${PriceShoppingCartIntIncrement} > ${PriceShoppingCartInt}

    Click Button    ${ButtonDecrease}
    Wait Until Element Is Not Visible With Long Time    ${ShoppingCartLoader}
    Wait Until Element Is Visible    ${ShoppingCartTotalPrice}
    ${PriceInShoppingCart}    Get Text    ${ShoppingCartTotalPrice}
    ${PriceShoppingCartIntDecrement}    Convert Price String To Integer    ${PriceInShoppingCart}
    Should Be True    ${PriceShoppingCartIntDecrement} < ${PriceShoppingCartIntIncrement}

    Wait Until Element Is Enabled    ${ShoppingCartDelete}
    Click Button    ${ShoppingCartDelete}
    Wait Until Element Is Visible With Long Time  ${ButtonStartShopping}

TCSC2.Customer deleted the item
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductVirtualSKUForSearch}
    Validate Search Product And Go To PDP    ${ProductVirtualNameForSearch}
    @{productName} =    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=@{productName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Wait Until Element Is Visible    ${MinicartSubtotal}
    ${PriceInMinicart}    Get Text    ${MinicartSubtotal}
    ${PriceMinicartInt}    Convert Price String To Integer    ${PriceInMinicart}
    Click Button    ${MinicartIncrease}
    Wait Until Element Is Not Visible With Long Time  ${MinicartLoader}
    Wait Until Element Is Visible    ${MinicartSubtotal}
    ${PriceInMinicart}    Get Text    ${MinicartSubtotal}
    ${PriceMinicartIntIncrement}    Convert Price String To Integer    ${PriceInMinicart}
    Should Be True    ${PriceMinicartIntIncrement} > ${PriceMinicartInt}
    Click Button    ${MinicartDecrease}
    Wait Until Element Is Not Visible With Long Time    ${MinicartLoader}
    Wait Until Element Is Visible    ${MinicartSubtotal}
    ${PriceInMinicart}    Get Text    ${MinicartSubtotal}
    ${PriceMinicartIntDecrement}    Convert Price String To Integer    ${PriceInMinicart}
    Should Be True    ${PriceMinicartIntDecrement} < ${PriceMinicartIntIncrement}
    Empty the items in MiniCart

