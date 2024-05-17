*** Settings ***
Library         SeleniumLibrary
Resource        ../base/common.robot
Resource        ../base/base.robot
Variables       ../resources/locators/product_detail_locator.py

*** Keywords ***
Input Item Qty
    [Arguments]    ${QTY}
    Wait Until Element Is Visible With Long Time    ${ProductQuantity}
    Clear Text Field    ${ProductQuantity}
    Input Text    ${ProductQuantity}    ${QTY}

Add To Cart
    Scroll Down To Element    ${AddToCartButton}
    Click Element    ${AddToCartButton}
