*** Settings ***
Library         SeleniumLibrary
Library         Collections
Resource        ../base/base.robot
Resource        ../pages/checkout_page.robot
Variables       ../resources/locators/cart_page_locator.py
Variables       ../resources/locators/scv2_locator.py


*** Keywords ***
Get Product Name From Minicart
    Wait Until Element Is Visible With Long Time    ${MinicartProductItem}
    ${totalItem}=    Get Element Count    ${MinicartProductItem}
    ${MiniCartItemList}=    Create List
    FOR    ${Item}    IN RANGE    1    ${totalItem+1}
        ${MinicartItemName}=    Get Text    ${MinicartProductName.format(${Item})}
        # ${GroupProductChild}    Get Text    ${GroupProductName.format(${Item})}
        Append To List    ${MiniCartItemList}    ${MinicartItemName}
    END
    RETURN    ${MiniCartItemList}

Error Item Added To Cart Not Match
    Fail
    ...    Data Nama Product yang ditambahkan ke kerangjang, tidak sesuai dengan data product dikeranjang

Validate The Similarity Of Item Added To Cart
    [Arguments]    &{Argument}
    ${Argument1}=    Set Variable    ${Argument['productName']}
    ${Argument2}=    Set Variable    ${Argument['MinicartProductNameValue']}
    Log    productName----: ${Argument1}
    Log    MinicartProductNameValue---: ${Argument2}
    ${TotalItem}=    Get Length    ${Argument2}
    IF    ${TotalItem} > 1
        Sort List    ${Argument1}
        Sort List    ${Argument2}
    END
    ${ValidateResult}=    Lists Should Be Equal    ${Argument1}    ${Argument2}
    IF    '${ValidateResult}'=='False'
        Run Keyword And Continue On Failure    Error Item Added To Cart Not Match
    END

Empty the items in MiniCart
    Go To Home Page
    Click Element    ${HeaderShoppingCartButton}
    ${present}=    Run Keyword and Return Status    Wait Until Page Contains Element    ${MinicartDeleteItem}
    WHILE    ${present}
        Click Element    ${MinicartDeleteItem}
        Wait Until Element Is Not Visible    ${LoadingPage}
        ${present}=    Run Keyword and Return Status    Wait Until Page Contains Element    ${MinicartDeleteItem}
    END
    Close The Minicart
    Go To Home Page

Open Minicart
    Click Element    ${HeaderShoppingCartButton}

Close The Minicart
    Wait Until Element Is Visible    ${BtnCloseMiniCart}
    Click Element    ${BtnCloseMiniCart}

Go To Shopping Cart
    ${ShowMinicart}    Run Keyword And Return Status    Wait Until Element Is Visible With Long Time    ${BtnCloseMiniCart}
    IF  not ${ShowMinicart}
            Open Minicart
    END
    Click Element    ${ButtonViewCart}
    Wait Until Element Is Visible With Long Time    ${ButtonToCheckout}

Go To Checkout Page From Shopping Cart
    Scroll Down To Element    ${ButtonToCheckout}
    Click Element    ${ButtonToCheckout}
    Wait Until Element Is Visible With Long Time    ${ButtonCheckoutogInSCV}

Go To Checkout Page From Shopping Cart Guest and Login User
    # Digunakan untuk masuk kehalaman Checkout Page untuk Guest ataupun Login User
    Scroll Down To Element    ${ButtonToCheckout}
    Click Element    ${ButtonToCheckout}
    ${CheckoutPagePresent}=    Run Keyword and Return Status    Wait Until Element Is Visible With Long Time    ${CheckoutPageCountdown}
    IF    not ${CheckoutPagePresent}
        Wait Until Element Is Visible With Long Time    ${ButtonCheckoutogInSCV}
        Login at the Checkout Page for Guest Users
    END
    Wait Until Element Is Visible    ${GrandTotalInSummary}    45s