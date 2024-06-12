*** Settings ***
Library         SeleniumLibrary
Library         Collections

Variables           ../resources/locators/home_locator.py
Variables           ../resources/locators/product_list_locator.py
Variables           ../resources/locators/product_detail_locator.py
Variables           ../resources/locators/wishlist_page_locator.py

Resource            ../base/common.robot
Resource            ../base/base.robot
Resource            ../base/setup.robot
Resource            ../pages/home_page.robot
Resource            ../pages/product_detail_page.robot
Resource            ../pages/product_list_page.robot
Resource            ../pages/cart_page.robot
Resource            ../pages/my_account_page.robot


*** Keywords ***
Add Product To Wishlist if Empty
    [Arguments]    ${VariabelProductName/SKU}
    ${status}=     Run Keyword and Return Status           Wait Until Page Contains Element        ${ProductWishlist}
    IF    '${status}'=='False'
        Add Product to Wishlist    ${VariabelProductName/SKU}
    END

Add Product to Wishlist
    [Arguments]    ${VariabelProductName/SKU}
    Go To Home Page
    Search Product by Keyword in Searchbox    ${VariabelProductName/SKU}
    Validate Search Product And Go To PDP    ${VariabelProductName/SKU}
    Click Button    ${BtnWishlist}
    Validate Message Success Alert Is Visible

Add Comment to Wishlist Product
    Wait Until Element Is Enabled    ${WishFieldComment}
    Clear Text Field    ${WishFieldComment}
    ${CommentWishlist}=    Generate Random Comment
    Input text    ${WishFieldComment}    ${CommentWishlist}
    Click Button    ${BtnUpdateWishlist}
    Validate Message Success Alert Is Visible

Remove Wishlist Product
    Wait Until Element Is Enabled    ${ProductWishlist}
    Scroll Down To Element    ${BtnRemoveWishlist}
    Click Element    ${BtnRemoveWishlist}
    Validate Message Success Alert Is Visible

Add To Cart Product from Wishlist
    Wait Until Element Is Enabled    ${ProductWishlist}
    Scroll Down To Element    ${BtnATCWishlist}
    Click Button        ${BtnATCWishlist}
    Validate Message Success Alert Is Visible

Add To Wishlist All Product Type
    [Arguments]    ${Qty}
    ${IsConfigurableProduct} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${ProductConfigurable}
    ${IsBundleProduct} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${ProductBundle}
    ${IsGroupProduct} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${ProductGroup}
    ${PDPProductNameValue} =    Get Product Name From PDP
    ${ProductNameList} =    Create List
    Append To List    ${ProductNameList}    ${PDPProductNameValue}
    IF    ${IsConfigurableProduct}
        Quantity Of Products    ${Qty}
        Select Configurable Product Option
    ELSE IF    ${IsBundleProduct}
        Customize Bundle Product
    ELSE IF    ${IsGroupProduct}
        Customize Group Product    ${ProductNameList}    ${Qty}
    ELSE
        Quantity Of Products    ${Qty}
    END
        Scroll Down To Element    ${BtnWishlist}
        Click Element    ${BtnWishlist}
    RETURN    ${ProductNameList}

Share Wishlist To Email
    Wait Until Element Is Enabled    ${ProductWishlist}
    Click Element    ${ShareWishlistButton}
    Wait Until Element Is Enabled    ${TextAreaEmailWishlist}
    Input Text    ${TextAreaEmailWishlist}    ${EmailShareWishlist}
    Input Text    ${TextAreaMessageWishlist}    ${MessageShareWishlist}
    Click Element    ${ShareToEmail}

Add To Cart All Product from Wishlist
    Wait Until Element Is Enabled    ${ProductWishlist}
    Scroll Down To Element    ${BtnATCAllProductWishlist}
    Click Button        ${BtnATCAllProductWishlist}
    Validate Message Success Alert Is Visible

Add to Cart a variant product from the Wishlist without selecting a variant
    Wait Until Element Is Enabled    ${ProductWishlist}
    Scroll Down To Element    ${BtnATCWishlist}
    Click Button        ${BtnATCWishlist}
    Validate Alert Message Is Visible