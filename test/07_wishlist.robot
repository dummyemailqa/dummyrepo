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
    Empty Item In Wishlish Page
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
    Empty Item In Wishlish Page
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
    Empty Item In Wishlish Page
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

L-TCWL3.4.Logged In User is able to Add to Cart Group Product from wishlist page
    [Tags]    wishlist
    Login User
    Empty the items in MiniCart
    Go To My Account Page
    Empty Item In Wishlish Page
    Search Product by Keyword in Searchbox    ${ProductGroupNameForSearch}
    Validate Search Product And Go To PDP    ${ProductGroupNameForSearch}
    @{productName} =    Add To Wishlist All Product Type    Qty=1
    Validate Message Success Alert Is Visible
    Add To Cart Product from Wishlist
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=${ProductName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart

L-TCWL3.5.Logged In User is able to Add to Cart Variant Product from wishlist page
    [Tags]    wishlist
    Login User
    Empty the items in MiniCart
    Go To My Account Page
    Empty Item In Wishlish Page
    Search Product by Keyword in Searchbox    ${ProductVirtualNameForSearch}
    Validate Search Product And Go To PDP    ${ProductVirtualNameForSearch}
    @{productName} =    Add To Wishlist All Product Type    Qty=1
    Validate Message Success Alert Is Visible
    Add To Cart Product from Wishlist
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=${ProductName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart

L-TCWL4.Logged In User is able to Add to Cart all product from wishlist page
    [Tags]    wishlist
    Login User
    Empty the items in MiniCart
    Go To My Account Page
    Empty Item In Wishlish Page

    # Add Simple Product To Wishlist
    Search Product by Keyword in Searchbox    ${ProductSimpleNameForSearch}
    Validate Search Product And Go To PDP    ${ProductSimpleNameForSearch}
    @{productName1} =    Add To Wishlist All Product Type    Qty=1
    Validate Message Success Alert Is Visible
    
    # Add Configurable Product To Wishlist
    Search Product by Keyword in Searchbox    ${ProductConfigNameForSearch}
    Validate Search Product And Go To PDP    ${ProductConfigNameForSearch}
    @{productName2} =    Add To Wishlist All Product Type    Qty=1
    Validate Message Success Alert Is Visible

    # Add Bundle Product To Wishlist
    Search Product by Keyword in Searchbox    ${ProductBundleNameForSearch}
    Validate Search Product And Go To PDP    ${ProductBundleNameForSearch}
    @{productName3} =    Add To Wishlist All Product Type    Qty=1
    Validate Message Success Alert Is Visible

    # Add Group Product To Wishlist
    Search Product by Keyword in Searchbox    ${ProductGroupNameForSearch}
    Validate Search Product And Go To PDP    ${ProductGroupNameForSearch}
    @{productName4} =    Add To Wishlist All Product Type    Qty=1
    Validate Message Success Alert Is Visible

    # Add Virtual Product To Wishlist
    Search Product by Keyword in Searchbox    ${ProductVirtualNameForSearch}
    Validate Search Product And Go To PDP    ${ProductVirtualNameForSearch}
    @{productName5} =    Add To Wishlist All Product Type    Qty=1
    Validate Message Success Alert Is Visible

    Add To Cart All Product from Wishlist
    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    ${allProductNames} =    Create List    @{productName1}    @{productName2}    @{productName3}    @{productName4}    @{productName5}
    &{Arguments} =    Create Dictionary    productName=${allProductNames}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart

L-TCWL5.Logged In User is able to share wishlist by email
    [Tags]    wishlist
    Login User
    To My Wishlist From Nav Bar
    ${WishListProductIsEmpty}    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${ProductWishlist}
    IF  ${WishListProductIsEmpty}
        Add Product to Wishlist    ${ProductConfigNameForSearch}
    END
    Share Wishlist To Email
    Validate Message Success Alert Is Visible

L-TCWL6.1.Logged In users are able to add a Configurable product to the cart from the wishlist page without selecting a product variant
    [Tags]    wishlist
    Login User
    Empty the items in MiniCart
    Go To My Account Page
    Empty Item In Wishlish Page
    Add Product to Wishlist    ${ProductConfigNameForSearch}

    #Add To Cart Configurable Product From Wishlist
    Add to Cart a variant product from the Wishlist without selecting a variant
     @{productName} =    Add To Cart    Qty=1
    Alert Success Validation

    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=@{productName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart

L-TCWL6.3.Logged In users are able to add a Group product to the cart from the wishlist page without selecting a product variant
    [Tags]    wishlist
    Login User
    Empty the items in MiniCart
    Go To My Account Page
    Empty Item In Wishlish Page
    Add Product to Wishlist    ${ProductGroupNameForSearch}

    #Add To Cart Configurable Product From Wishlist
    Add to Cart a variant product from the Wishlist without selecting a variant
     @{productName} =    Add To Cart    Qty=1
    Alert Success Validation

    Open Minicart
    @{MinicartProductNameValue} =    Get Product Name From Minicart
    &{Arguments} =    Create Dictionary    productName=@{productName}    MinicartProductNameValue=@{MinicartProductNameValue}
    Validate The Similarity Of Item Added To Cart    &{Arguments}
    Close The Minicart