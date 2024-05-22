*** Settings ***
Documentation       Suite description
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/home_page.robot
Resource            ../pages/product_detail_page.robot
Resource            ../pages/product_list_page.robot
Variables           ../resources/locators/product_list_locator.py
Variables           ../resources/data/testdata.py

Test Setup          Start Test Case
Test Teardown       End Test Case

*** Test Cases ***
TCPDP2-L.Validation Product Review Submission with Empty Required Fields
    [Tags]    PDP
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

TCPDP5.Validation Maximum Quantity Validation During Adding Product to Cart
    [Tags]    pdp
    Search Product by Keyword in Searchbox    ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible    ${ProductItemCard}
    Go To PDP Product By Index    1
    Input Item Qty    QTY=10001
    Add To Cart
    Validate Popup Fail Alert Is Visible     elementjs=${ProductQuantityValidation}

TCPDP6.Customers cannot add items to the cart
    [Tags]    PDP
    Search Product by Keyword in Searchbox  ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible   ${ProductItemCard}
    Go To PDP Product By Index    1
    Input Item Qty    QTY=0
    Add To Cart
    Validate Popup Fail Alert Is Visible    elementjs=${ProductQuantityValidation}
    Validate Popup Fail Alert Is Visible    elementjs=${ProductQuantityValidation}
