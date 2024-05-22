*** Settings ***
Library         SeleniumLibrary
Resource        ../base/common.robot
Resource        ../base/base.robot
Variables       ../resources/locators/product_detail_locator.py
Variables       ../resources/locators/login_locator.py

*** Keywords ***
Input Item Qty
    [Arguments]    ${QTY}
    Wait Until Element Is Visible With Long Time    ${ProductQuantity}
    Clear Text Field    ${ProductQuantity}
    Input Text    ${ProductQuantity}    ${QTY}

Add To Cart
    Scroll Down To Element    ${AddToCartButton}
    Click Element    ${AddToCartButton}

Open Review Product Window
    Wait Until Element Is Visible With Long Time    ${AddToCartButton}
    Scroll Down To Element    ${ProductReviewButton}
    Wait Until Element Is Visible With Long Time    ${ProductReviewButton}
    Click Element    ${ProductReviewButton}
    Wait Until Element Is Visible With Long Time    ${ReviewSubmitButton}

Input Review Product
    [Arguments]    ${Nickname}    ${Title}    ${Review}    ${Rate}
    Input Text    ${ReviewNameInput}    ${Nickname}
    IF  '${Rate}' != "0"
        Click Element    ${ReviewRatingButton.format(${Rate})}
    END
    Input Text    ${ReviewTitleInput}    ${Title}
    Input Text    ${ReviewDetailInput}    ${Review}
    Click Element    ${ReviewSubmitButton}

Cancel Review Product
    Wait Until Element Is Visible With Long Time    ${ReviewCancelSubmitButton}
    Click Element    ${ReviewCancelSubmitButton}
    Wait Until Element Is Not Visible    ${ReviewCancelSubmitButton}

Add To Wishlist From PDP
    Wait Until Element Is Visible With Long Time    ${ProductNameOnPDP}
    Scroll Down To Element    ${AddToWishListButton}
    Click Element    ${AddToWishListButton}

Validate Guest User Add To Wishlist
    Validate Message Error Alert Is Visible
    Wait Until Element Is Visible With Long Time    ${FromLogin}