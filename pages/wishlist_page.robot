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
Check Product on Wishlist
    ${status}=     Run Keyword and Return Status           Wait Until Page Contains Element        ${ProductWishlist}
    IF    '${status}'=='False'
        Add Product to Wishlist
    END

Add Product to Wishlist
    Go To Home Page
    Empty the items in MiniCart
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Go To PDP Product
    Search Product result Validation    ${ProductSimpleNameForSearch}
    ${PDPProductNameValue} =    Get Product Name From PDP ATC
    Click Button    ${BtnWishlist}
    To My Wishlist From Nav Bar

Add Comment to Wishlist Product
    Wait Until Element Is Enabled    ${WishFieldComment}
    Clear Text Field    ${WishFieldComment}
    ${CommentWishlist}=    Generate Random Comment
    Input text    ${WishFieldComment}    ${CommentWishlist}
    Click Button    ${BtnUpdateWishlist}
