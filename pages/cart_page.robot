*** Settings ***
Library         SeleniumLibrary
Library         RequestsLibrary
Library         JSONLibrary
Library         String
Library         Collections
Resource        ../base/base.robot
Resource        ../pages/checkout_page.robot
Variables       ../resources/data/testdata.py
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
    ${isGuest}=    Run Keyword And Return Status    
    ...    Element Attribute Value Should Be    ${CustomerMenuFirstItem}    id    customer.header.sign.in.link
    Scroll Down To Element    ${ButtonToCheckout}
    Click Element    ${ButtonToCheckout}
    IF    ${isGuest}
        Wait Until Element Is Visible With Long Time    ${ButtonCheckoutogInSCV}
        Login at the Checkout Page for Guest Users
    END
    Wait Until Element Is Visible    ${GrandTotalInSummary}    45s

Generate Customer Token
    [Arguments]    ${email}    ${password}
    ${queryJSON}=    Load Json From File    ./resources/queries/generateCustomerToken.json
    
    Set To Dictionary    ${queryJSON['variables']}    email    ${email}
    Set To Dictionary    ${queryJSON['variables']}    password    ${password}

    ${res}=    POST    url=${graphqlURL}    json=${queryJSON}
    ${token}=    Set Variable    ${res.json()}[data][generateCustomerToken][token]
    RETURN    ${token}

Get Customer Cart
    [Arguments]    ${token}
    ${queryJSON}=    Load Json From File    ./resources/queries/customerCart.json
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}

    ${res}=    POST    url=${graphqlURL}    json=${queryJSON}    headers=${headers}
    ${cart}=    Set Variable    ${res.json()}
    
    RETURN    ${cart}

Get Customer Cart Id
    [Arguments]    ${cart}
    ${cartId}=    Set Variable    ${cart}[data][customerCart][id]

    RETURN    ${cartId}

Get Customer Cart Items
    [Arguments]    ${cart}
    ${cartItems}=    Set Variable    ${cart}[data][customerCart][items]

    RETURN    ${cartItems}

Remove Customer Cart Item
    [Arguments]    ${token}    ${cartId}    ${cartItemId}
    ${queryJSON}=    Load Json From File    ./resources/queries/removeItemFromCart.json
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    
    Set To Dictionary    ${queryJSON['variables']}    cart_id    ${cartId}
    Set To Dictionary    ${queryJSON['variables']}    cart_item_uid    ${cartItemId}

    ${res}=    POST    url=${graphqlURL}    json=${queryJSON}    headers=${headers}

Clear Customer Cart Items
    [Arguments]    ${email}    ${password}
    ${token}=    Generate Customer Token    ${email}    ${password}
    ${cart}=    Get Customer Cart    ${token}
    ${cartId}=    Get Customer Cart Id    ${cart}
    ${cartItems}=    Get Customer Cart Items    ${cart}
    @{cartItems}=    Convert To List    ${cartItems}
    FOR    ${item}    IN    @{cartItems}
        Remove Customer Cart Item    ${token}    ${cartId}    ${item}[uid]
    END