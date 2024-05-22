*** Settings ***
Library         SeleniumLibrary
Library         Collections
Variables       ../resources/locators/my_account_locator.py
Variables       ../resources/locators/home_locator.py
Resource        ../base/common.robot

*** Keywords ***
Go To Wishlist Page
    Wait Until Element Is Visible                           ${UserLoggedInIcon}
    Mouse Over                                              ${UserLoggedInIcon}
    Click Element                                           ${CustomerMenuWishlist}
    Wait Until Element Is Visible With Long Time            ${WishlistProductList}
