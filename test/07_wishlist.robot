*** Settings ***
Documentation       Suite description
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/login_page.robot
Resource            ../pages/my_account_page.robot
Resource            ../pages/wishlist_page.robot

Test Setup          Start Test Case
Test Teardown       End Test Case

*** Test Cases ***
L-TCWL1.Logged In user is able to add comment to the product at wishlist page
    [Tags]    wishlist
    Login User
    To My Wishlist From Nav Bar
    Add Product To Wishlist if Empty    ${ProductVirtualNameForSearch}
    Add Comment to Wishlist Product
    
L-TCWL2.Logged In user is able to delete product from wishlist page
    [Tags]    wishlist
    Login User
    To My Wishlist From Nav Bar
    Add Product To Wishlist if Empty    ${ProductVirtualNameForSearch}
    Remove Wishlist Product

L-TCWL3.1.Logged In User is able to Add to Cart Simple Product from wishlist page
    [Tags]    wishlist
    Login User
    Empty the items in MiniCart
    Go To My Account Page
    Emty Item In Wishlish Page
    Search Product by Keyword in Searchbox    ${ProductSimpleNameForSearch}
    Validate Search Product And Go To PDP    ${ProductSimpleNameForSearch}
    @{productName} =    Add To Wishlist All Product Type    Qty=1
    Validate Message Success Alert Is Visible
    Add To Cart Product from Wishlist
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=${ProductName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart

L-TCWL3.2.Logged In User is able to Add to Cart Configurable Product from wishlist page
    [Tags]    wishlist
    Login User
    Empty the items in MiniCart
    Go To My Account Page
    Emty Item In Wishlish Page
    Search Product by Keyword in Searchbox    ${ProductConfigNameForSearch}
    Validate Search Product And Go To PDP    ${ProductConfigNameForSearch}
    @{productName} =    Add To Wishlist All Product Type    Qty=1
    Validate Message Success Alert Is Visible
    Add To Cart Product from Wishlist
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=${ProductName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart

L-TCWL3.3.Logged In User is able to Add to Cart Bundle Product from wishlist page
    [Tags]    wishlist
    Login User
    Empty the items in MiniCart
    Go To My Account Page
    Emty Item In Wishlish Page
    Search Product by Keyword in Searchbox    ${ProductBundleNameForSearch}
    Validate Search Product And Go To PDP    ${ProductBundleNameForSearch}
    @{productName} =    Add To Wishlist All Product Type    Qty=1
    Validate Message Success Alert Is Visible
    Add To Cart Product from Wishlist
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=${ProductName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart