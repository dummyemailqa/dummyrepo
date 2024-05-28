*** Settings ***
Documentation       Suite description

Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/home_page.robot
Resource            ../pages/login_page.robot
Resource            ../pages/product_detail_page.robot
Resource            ../pages/product_list_page.robot
Resource            ../pages/cart_page.robot
Resource            ../pages/compare_page.robot
Resource            ../pages/my_account_page.robot
Variables           ../resources/locators/compare_locator.py

Test Setup          Start Test Case
Test Teardown       End Test Case


*** Test Cases ***
L-TCPDP1.Customer submit product reviews
    [Tags]  pdp
    #Login
    To Login Page
    Input Login Form    ${EmailAddressRegistered}  ${Password}
    Submit Form Login
    Login Validation
    #search Product Simple by SKU
    Search Product by Keyword in Searchbox  ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time  ${ProductItemCard}
    Element Should Be Visible  ${ProductItemCard}
    Go To PDP Product By Index  1
    Open Review Product Window
    Input Review Product    Nickname=${ProductReviewName}    Title=${ProductReviewTitle}   Review=${ProductReviewDetail}  Rate=4
    Alert Visible Validation  ${ReviewAlertSuccess} 

G-TCPDP1.Guest customers submit product reviews when feature guest product review configuration enable
    [Tags]   pdp
    #search Product Simple by SKU
    Search Product by Keyword in Searchbox  ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time  ${ProductItemCard}
    Element Should Be Visible  ${ProductItemCard}
    Go To PDP Product By Index  1

    Open Review Product Window
    Input Review Product    Nickname=${ProductReviewName}    Title=${ProductReviewTitle}   Review=${ProductReviewDetail}  Rate=4
    Alert Visible Validation  ${ReviewAlertSuccess} 

L-TCPDP2.Validation Product Review Submission with Empty Required Fields
    [Tags]    pdp
    #search Product Simple by SKU
    Search Product by Keyword in Searchbox    ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible    ${ProductItemCard}
    Go To PDP Product By Index    1

    Open Review Product Window
    Input Review Product    Nickname=${EMPTY}    Title=${EMPTY}    Review=${EMPTY}    Rate=0
    Validate Popup Fail Alert Is Visible    elementjs=${ReviewNameInputValidation}

    # Open Review Product Window
    Input Review Product    Nickname=${ProductReviewName}    Rate=0    Title=${EMPTY}    Review=${EMPTY}
    Validate Popup Fail Alert Is Visible    elementjs=${ReviewRatingInputValidation}

    Input Review Product    Nickname=${ProductReviewName}    Rate=5    Title=${EMPTY}    Review=${EMPTY}
    Validate Popup Fail Alert Is Visible    elementjs=${ReviewTitleInputValidation}

    Input Review Product    Nickname=${ProductReviewName}    Rate=5    Title=${ProductReviewTitle}    Review=${EMPTY}
    Validate Popup Fail Alert Is Visible    elementjs=${ReviewDetailInputValidation}
    Cancel Review Product

TCPDP4-1.Add To Cart Simple Product
    [Tags]    ATC
    Go To Home Page
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Go To PDP Product
    Search Product Suggestion Validation PDP    ${ProductSimpleNameForSearch}
    ${PDPProductNameValue} =    Get Product Name From PDP ATC
    Quantity Of Products    2
    Add To Cart
    Alert Success Validation
    Open Minicart
    ${MinicartProductNameValue} =    Get Product Name From Minicart
    Validate The Similarity Of Item Added To Cart    ${PDPProductNameValue}    ${MinicartProductNameValue}
    Close The Minicart

TCPDP4-2.Add To Cart Configurable Product
    [Tags]    ATC
    Go To Home Page
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductConfigSKUForSearch}
    Wait Until Element Is Visible   ${ProductItemCard}
    Search Product Suggestion Validation PDP    ${ProductConfigNameForSearch}
    ${PDPProductNameValue} =    Get Product Name From PDP ATC
    Alert Success Validation
    Quantity Of Products    1
    Add To Cart
    Alert Success Validation
    Open Minicart
    ${MinicartProductNameValue} =    Get Product Name From Minicart
    Validate The Similarity Of Item Added To Cart    ${PDPProductNameValue}    ${MinicartProductNameValue}
    Close The Minicart

TCPDP4-3.Add To Cart Bundle Product
    [Tags]    ATC
    Go To Home Page
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductBundleSKUForSearch}
    Wait Until Element Is Visible    ${ProductItemCard}
    Search Product Suggestion Validation PDP    ${ProductBundleNameForSearch}
    Alert Success Validation
    ${PDPProductNameValue} =    Get Product Name From PDP ATC
    Add To Cart
    Alert Success Validation
    Open Minicart
    ${MinicartProductNameValue} =    Get Product Name From Minicart
    Validate The Similarity Of Item Added To Cart    ${PDPProductNameValue}    ${MinicartProductNameValue}
    Close The Minicart

TCPDP4-5.Add To Cart Virtual Product
    [Tags]    ATC
    Go To Home Page
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductVirtualSKUForSearch}
    Wait Until Element Is Visible    ${ProductItemCard}
    Search Product Suggestion Validation PDP    ${ProductVirtualNameForSearch}
    Alert Success Validation
    ${PDPProductNameValue} =    Get Product Name From PDP ATC
    Quantity Of Products    2
    Add To Cart
    Alert Success Validation
    Open Minicart
    ${MinicartProductNameValue} =    Get Product Name From Minicart
    Validate The Similarity Of Item Added To Cart    ${PDPProductNameValue}    ${MinicartProductNameValue}
    Close The Minicart

TCPDP5.Validation Maximum Quantity Validation During Adding Product to Cart
    [Tags]    pdp
    Search Product by Keyword in Searchbox    ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible    ${ProductItemCard}
    Go To PDP Product By Index    1
    Input Item Qty    QTY=10001
    Add To Cart
    Validate Popup Fail Alert Is Visible    elementjs=${ProductQuantityValidation}

TCPDP6.Customers cannot add items to the cart
    [Tags]    pdp
    Search Product by Keyword in Searchbox    ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible    ${ProductItemCard}
    Go To PDP Product By Index    1
    Input Item Qty    QTY=0
    Add To Cart
    Validate Popup Fail Alert Is Visible    elementjs=${ProductQuantityValidation}

TCPDP7.cannot add product to wish list and cannot access the wishlist page
    [Tags]    pdp
    Search Product by Keyword in Searchbox    ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible    ${ProductItemCard}
    Go To PDP Product By Index    1

    Add To Wishlist From PDP
    Validate Guest User Add To Wishlist

TCPDP8.Logged in user is able to add product to wish list and access the wishlist page.
    [Tags]    pdp
    Login User
    Emty Item In Wishlish Page
    Search Product by Keyword in Searchbox    ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible    ${ProductItemCard}
    Go To PDP Product By Index    1

    ${PDPProductName}    Get Product Name From PDP
    Add To Wishlist From PDP
    ${WishlistPageProductName}    Get Product Name From Wishlish Page
    Validate The Similarity Of Item Added To Wishlist    ${PDPProductName}    ${WishlistPageProductName}

G-TCPDP9.Guest can add product and access comparison page
    Go To Home Page
    Open Compare Page
    Remove Products in Compare Page
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Go To PDP Product
    ${PDPProductName1Value} =    Get Product Name From PDP ATC
    Click Element    ${CompareButtonPDP}
    Validate Message Success Alert Is Visible
    Go To Home Page
    Search Product by Keyword in Searchbox    ${ProductVirtualSKUForSearch}
    ${PDPProductName2Value} =    Get Product Name From PDP ATC
    Click Element    ${CompareButtonPDP}
    Validate Message Success Alert Is Visible
    Open Compare Page
    ${CompareProductName1Value} =    Get Text From Locator    ${CompareProductName1}
    ${CompareProductName2Value} =    Get Text From Locator    ${CompareProductName2}
    Validate The Similarity Of Item Added To Compare    ${PDPProductName1Value}    ${CompareProductName2Value}
    Validate The Similarity Of Item Added To Compare    ${PDPProductName2Value}    ${CompareProductName1Value}
    Go To Home Page

L-TCPDP10.Logged in user can add product and access comparison page
    Login User
    Go To Home Page
    Open Compare Page
    Remove Products in Compare Page
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Go To PDP Product
    ${PDPProductName1Value} =    Get Product Name From PDP ATC
    Click Element    ${CompareButtonPDP}
    Validate Message Success Alert Is Visible
    Go To Home Page
    Search Product by Keyword in Searchbox    ${ProductVirtualSKUForSearch}
    ${PDPProductName2Value} =    Get Product Name From PDP ATC
    Click Element    ${CompareButtonPDP}
    Validate Message Success Alert Is Visible
    Open Compare Page
    ${CompareProductName1Value} =    Get Text From Locator    ${CompareProductName1}
    ${CompareProductName2Value} =    Get Text From Locator    ${CompareProductName2}
    Validate The Similarity Of Item Added To Compare    ${PDPProductName1Value}    ${CompareProductName2Value}
    Validate The Similarity Of Item Added To Compare    ${PDPProductName2Value}    ${CompareProductName1Value}
    Go To Home Page