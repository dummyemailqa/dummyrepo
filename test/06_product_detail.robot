*** Settings ***
Documentation       Suite description
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/login_page.robot
Resource            ../pages/product_detail_page.robot
Resource            ../pages/product_list_page.robot
Resource            ../pages/cart_page.robot
Resource            ../pages/home_page.robot
Resource            ../pages/compare_page.robot
Resource            ../pages/my_account_page.robot
Variables           ../resources/locators/compare_locator.py

Test Setup          Start Test Case
Test Teardown       End Test Case


*** Test Cases ***
L-TCPDP1.Customer submit product reviews
    [Tags]  pdp
    #Login
    Login User
    #search Product Simple by SKU
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Validate Search Product And Go To PDP   ${ProductSimpleNameForSearch}
    Open Review Product Window
    Input Review Product    Nickname=${ProductReviewName}    Title=${ProductReviewTitle}   Review=${ProductReviewDetail}  Rate=4
    Wait Until Element Is Not Visible With Long Time    ${ReviewSubmitButton}

G-TCPDP1.Guest customers submit product reviews when feature guest product review configuration enable
    [Tags]   pdp
    #search Product Simple by SKU
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Validate Search Product And Go To PDP   ${ProductSimpleNameForSearch}

    Open Review Product Window
    Input Review Product    Nickname=${ProductReviewName}    Title=${ProductReviewTitle}   Review=${ProductReviewDetail}  Rate=4
    Wait Until Element Is Not Visible With Long Time    ${ReviewSubmitButton}

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
    
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Validate Search Product And Go To PDP    ${ProductSimpleNameForSearch}
     @{productName} =    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=@{productName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart

TCPDP4-2.Add To Cart Configurable Product
    [Tags]    ATC
    
    Search Product by Keyword in Searchbox    ${ProductConfigSKUForSearch}
    Validate Search Product And Go To PDP    ${ProductConfigNameForSearch}
     @{productName} =    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=@{productName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart

TCPDP4-3.Add To Cart Bundle Product
    [Tags]    ATC
    
    Search Product by Keyword in Searchbox    ${ProductBundleSKUForSearch}
    Validate Search Product And Go To PDP    ${ProductBundleNameForSearch}
     @{productName} =    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=@{productName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart

TCPDP4-4.Add To Cart Virtual Product
    [Tags]    pdp
    
    Search Product by Keyword in Searchbox    ${ProductVirtualSKUForSearch}
    Validate Search Product And Go To PDP    ${ProductVirtualNameForSearch}
     @{productName} =    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=@{productName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart

TCPDP4.5.Customers add product Grouped to the cart from PDP
    [Tags]    pdp
    
    Search Product by Keyword in Searchbox    ${ProductGroupSKUForSearch}
    Validate Search Product And Go To PDP   ${ProductGroupNameForSearch}
    
    @{productName} =    Add To Cart    Qty=1
    Alert Success Validation
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=@{productName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart
    
TCPDP5.Validation Maximum Quantity Validation During Adding Product to Cart
    [Tags]    pdp
    
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Validate Search Product And Go To PDP   ${ProductSimpleNameForSearch}
    Add To Cart    Qty=10001
    Validate Popup Fail Alert Is Visible    elementjs=${ProductQuantityValidation}

TCPDP6.Customers cannot add items to the cart
    [Tags]    pdp
    
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Validate Search Product And Go To PDP   ${ProductSimpleNameForSearch}
    Add To Cart    Qty=10001
    Validate Popup Fail Alert Is Visible    elementjs=${ProductQuantityValidation}

TCPDP7.cannot add product to wish list and cannot access the wishlist page
    [Tags]    pdp    wishlist
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Validate Search Product And Go To PDP   ${ProductSimpleNameForSearch}

    Add To Wishlist From PDP
    Validate Guest User Add To Wishlist

TCPDP8.Logged in user is able to add product to wish list and access the wishlist page.
    [Tags]    pdp    wishlist
    Login User
    Empty Item In Wishlish Page
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Validate Search Product And Go To PDP   ${ProductSimpleNameForSearch}

    ${PDPProductName}    Get Product Name From PDP
    Add To Wishlist From PDP
    Validate Message Success Alert Is Visible
    ${WishlistPageProductName}    Get Product Name From Wishlish Page
    Validate The Similarity Of Item Added To Wishlist    ${PDPProductName}    ${WishlistPageProductName}

G-TCPDP9.Guest can add product and access comparison page
    [Tags]    pdp
    Go To Home Page
    Open Compare Page
    Remove Products in Compare Page
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Validate Search Product And Go To PDP   ${ProductSimpleNameForSearch}
    ${PDPProductName1Value} =    Get Product Name From PDP
    Click Element    ${CompareButtonPDP}
    Validate Message Success Alert Is Visible
    Go To Home Page
    Search Product by Keyword in Searchbox    ${ProductVirtualSKUForSearch}
    ${PDPProductName2Value} =    Get Product Name From PDP
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
    Validate Search Product And Go To PDP   ${ProductSimpleNameForSearch}
    ${PDPProductName1Value} =    Get Product Name From PDP
    Click Element    ${CompareButtonPDP}
    Validate Message Success Alert Is Visible
    Go To Home Page
    Search Product by Keyword in Searchbox    ${ProductVirtualSKUForSearch}
    Validate Search Product And Go To PDP   ${ProductVirtualNameForSearch}
    ${PDPProductName2Value} =    Get Product Name From PDP
    Click Element    ${CompareButtonPDP}
    Validate Message Success Alert Is Visible
    Open Compare Page
    ${CompareProductName1Value} =    Get Text From Locator    ${CompareProductName1}
    ${CompareProductName2Value} =    Get Text From Locator    ${CompareProductName2}
    Validate The Similarity Of Item Added To Compare    ${PDPProductName1Value}    ${CompareProductName2Value}
    Validate The Similarity Of Item Added To Compare    ${PDPProductName2Value}    ${CompareProductName1Value}
    Go To Home Page

TCPDP11.Customers can share content through social media platforms
    [Tags]    pdp
    # Login User
    Go To Home Page
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Go To PDP Product
    # Share to WhatsApp
    Wait Until Element Is Visible With Long Time    ${PDPProductName}
    Scroll Down To Element    ${whatsappShareBtn}
    Click Element    ${whatsappShareBtn}
    ${window_handles}=    Get Window Handles
    Switch Window         ${window_handles[1]}
    ${CurrentURL} =  Execute Javascript  return window.location.href;
    Close Window
    Switch Window    MAIN
    Log To Console    ${CurrentURL}
    Should Contain    ${CurrentURL}    ${URLwhatsapp} 
    # Share to Facebook
    Click Element    ${FacebookShareBtn}
    Switch Window    ${FacebookWindows}
    ${CurrentURL} =  Execute Javascript  return window.location.href;
    Close Window
    Switch Window    MAIN
    Log To Console    ${CurrentURL}
    Should Contain    ${CurrentURL}    ${URLFacebook}
    # Share to Twitter
    Click Element    ${TwitterShareBtn}
    Switch Window    ${TwitterWindows}
    ${CurrentURL} =  Execute Javascript  return window.location.href;
    Close Window
    Switch Window    MAIN
    Log To Console    ${CurrentURL}
    Should Contain    ${CurrentURL}    ${URLTwitter}