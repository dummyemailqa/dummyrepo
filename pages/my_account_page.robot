*** Settings ***
Library         SeleniumLibrary
Library         Collections
Variables       ../resources/locators/my_account_locator.py
Variables       ../resources/locators/home_locator.py
Resource        ../base/common.robot
Resource        ../base/base.robot


*** Keywords ***
To My Wishlist From User Menu
    Wait Until Element Is Visible    ${UserLoggedInIcon}
    Click Element    ${UserLoggedInIcon}
    Wait Until Element Is Enabled    ${CustomerMenuWishlist}
    Click Element    ${CustomerMenuWishlist}
    Wait Until Element Is Visible With Long Time    ${WishlishPage}

To My Wishlist From Nav Bar
    Wait Until Element Is Visible With Long Time    ${MyWishlistMenu}
    Click Element    ${MyWishlistMenu}
    Wait Until Element Is Visible With Long Time    ${WishlishPage}

Emty Item In Wishlish Page
    To My Wishlist From Nav Bar
    ${present}=    Run Keyword and Return Status
    ...    Wait Until Element Is Visible With Long Time
    ...    ${DeleteWishlistItemButton}
    WHILE    ${present}
        Wait Until Element Is Visible With Long Time    ${DeleteWishlistItemButton}
        Scroll Down To Element    ${DeleteWishlistItemButton}
        Click Element    ${DeleteWishlistItemButton}
        Validate Message Success Alert Is Visible
        ${WishlistItemIsEmty}=
        ...    Run Keyword and Return Status
        ...    Wait Until Element Is Visible
        ...    ${MessageInfoEmty}
        IF    ${WishlistItemIsEmty}    BREAK
        ${present}=    Run Keyword and Return Status
        ...    Wait Until Element Is Visible With Long Time
        ...    ${DeleteWishlistItemButton}
    END

Get Product Name From Wishlish Page
    Wait Until Element Is Visible With Long Time    ${WishlistPageProductName}
    ${ProductNameValue}=    Get Text    ${WishlistPageProductName}
    RETURN    ${ProductNameValue}

Error Item Added To Wishlist Not Match
    [Arguments]    ${Argument1}    ${Argument2}
    Fail
    ...    Data Nama Product yang ditambahkan dari pdp : -'${Argument1}'- tidak sesuai dengan data product di halaman Wishlist : -'${Argument2}'-

Validate The Similarity Of Item Added To Wishlist
    [Arguments]    ${Argument1}    ${Argument2}
    ${ValidateResult}=    Validate Similarity Of 2 Arguments    ${Argument1}    ${Argument2}
    IF    '${ValidateResult}'=='False'
        Run Keyword And Continue On Failure    Error Item Added To Wishlist Not Match    ${Argument1}    ${Argument2}
    END
