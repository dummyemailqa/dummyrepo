*** Settings ***
Library    String
Documentation   Suite description
Variables   ../resources/locators/product_list_locator.py
Variables   ../resources/locators/base_locator.py
Variables   ../resources/locators/home_locator.py
Variables   ../resources/data/testdata.py
Resource    ../base/setup.robot
Resource    ../base/base.robot
Resource    ../base/common.robot
Resource    ../pages/home_page.robot
Resource    ../pages/cart_page.robot
Resource    ../pages/product_list_page.robot

Test Setup          Start Test Case
Test Teardown       End Test Case



*** Keywords ***
*** Variables ***
@{productName}

*** Test Cases ***
TCPLP1.Customers able to Change product view as Grid on PLP
    [Tags]    PLP
    # View as List
    Wait Until Element Is Visible in 10s    ${MenuWoman}
    CLick Element    ${MenuWoman}
    Wait Until Element Is Visible in 10s    ${ProductsListViewIcon}
    Click Element    ${ProductsListViewIcon}
    Wait Until Element Is Visible    ${ProductListViewContainer}
    Element Should Be Visible    ${ProductListViewContainer}

    # View as Grid
    Wait Until Element Is Visible in 10s    ${ProductsGridViewIcon}
    Click Element   ${ProductsGridViewIcon}
    Wait Until Page Contains Element    ${ProductGridViewContainer}

TCPLP2.1.Customers add simple product to the cart from PLP
    [Tags]    PLP  
    #search Product Simple by SKU
    Search Product by Keyword in Searchbox                  ${ProductSimpleSKUForSearch}
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Element Should Be Visible                               ${ProductItemCard}
    Scroll Down To Element    ${AddToCartButtonInPLP.format(1)}
        ${totalOption} =    Get Element Count    ${ProductItemBasedForm}
        FOR    ${Option}    IN RANGE    1    ${totalOption+1}
           ${IsSimple}    Run Keyword And Return Status    Wait Until Element Is Not Visible      ${SummarySwatchOption.format(${Option})}    3s
            IF     ${IsSimple}
                Click Element    ${AddToCartButtonInPLP.format(${Option})}
                Wait Until Element Is Visible in 10s    ${SuccessAddToCartAllert} 
                Wait Until Element Is Visible With Long Time    ${ProductItemCardName.format(${Option})}
                ${TempProductName} =   Get Text    ${ProductItemCardName.format(${Option})}
                Append To List     ${productName}    ${TempProductName}
               
                Open Minicart
                @{MinicartProductNameValue} =    Get Product Name From Minicart
                &{Arguments} =    Create Dictionary    productName=${productName}    MinicartProductNameValue=@{MinicartProductNameValue}
                Validate The Similarity Of Item Added To Cart    &{Arguments}
                Pass Execution    'Passed'     
            END
        END
    Fail
    
TCPLP2.2.Customers add configurable product to the cart from PLP
    [Tags]    PLP  
    #search Product Configurable by SKU
    Search Product by Keyword in Searchbox                  ${ProductConfigSKUForSearch}
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Element Should Be Visible                               ${ProductItemCard}
    
    ${IndexButton}    Search Result Counter in PLP
    Scroll Down To Element    ${AddToCartButtonInPLP.format(${IndexButton})}
        ${totalOption} =    Get Element Count    ${ProductItemBasedForm}

        ${productName}    Create List

        FOR    ${Option}    IN RANGE    1    ${totalOption+1}
           ${IsConfigurable}    Run Keyword And Return Status    Wait Until Element Is Visible in 10s     ${SummarySwatchOption.format(${Option})}
            IF    ${IsConfigurable}
                ${totalOptionVariant} =  Get Element Count  ${SummarySwatchOption.format(${Option})}
                Wait Until Element Is Visible With Long Time    ${ProductItemCardName.format(${Option})}
                ${TempProductName} =   Get Text    ${ProductItemCardName.format(${Option})}
                Append To List     ${productName}    ${TempProductName}
                
                FOR  ${OptionVarian}  IN RANGE  1  ${totalOptionVariant+1}
                    Click Element    ${ProductOption.format(${Option},${OptionVarian})}
                END
                Click Element    ${AddToCartButtonInPLP.format(${IndexButton})}
                Wait Until Element Is Visible in 10s    ${SuccessAddToCartAllert} 
                    
                Open Minicart
                @{MinicartProductNameValue} =    Get Product Name From Minicart
                &{Arguments} =    Create Dictionary    productName=${productName}    MinicartProductNameValue=@{MinicartProductNameValue}
                Validate The Similarity Of Item Added To Cart    &{Arguments}
                Pass Execution    'Passed' 
            END
        END
    Fail
    


TCPLP4.Customers sort products
    [Tags]    PLP  
    #Sort by Low Price
    Search Product by Keyword in Searchbox                  ${CategoryForSearch}
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Element Should Be Visible                               ${ProductItemCard}
    Click Element    ${SortButton} 
    Click Element    ${SortOptionPrice} 
    Sorting Correct Validation  ${SortAsc}    ${productItemPrice.format(1)}   ${productItemPrice.format(2)}    ${productItemPrice.format(3)}
   

