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
    [Tags]    plp    guest-user
    # View as List
    Click Category Menu   ${MenuWoman}
    View Products as List in PLP

    # View as Grid
    View Products Grid in PLP

TCPLP2.1.Customers add simple product to the cart from PLP
    [Tags]    plp    guest-user  
    Click Category Menu   ${MenuWoman}
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}

        ${totalOption} =    Get Element Count    ${ProductItemBasedForm}
        FOR    ${Option}    IN RANGE    1    ${totalOption+1}
            Scroll Down To Element    ${AddToCartButtonInPLP.format(${Option})}   
            ${IsSimple}    Run Keyword And Return Status   Wait Until Element Is Not Visible  ${SummarySwatchOption.format(${Option})}    3s
            IF     ${IsSimple}
                Click Element    ${AddToCartButtonInPLP.format(${Option})}
                Validate Message Success Alert Is Visible 
                
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
    [Tags]    plp    guest-user  
    Click Category Menu   ${MenuWoman}
    
        ${totalOption} =    Get Element Count    ${ProductItemBasedForm}
        ${productName}    Create List
        FOR    ${Option}    IN RANGE    1    ${totalOption+1}
            Scroll Up To Element    ${ProductItemCardName.format(${Option})}
            ${IsConfigurable}    Run Keyword And Return Status   Wait Until Element Is Visible in 10s  ${SummarySwatchOption.format(${Option})}
            IF    ${IsConfigurable}
                ${totalOptionVariant} =  Get Element Count  ${SummarySwatchOption.format(${Option})}
                Wait Until Element Is Visible With Long Time    ${ProductItemCardName.format(${Option})}
                ${TempProductName} =   Get Text    ${ProductItemCardName.format(${Option})}
                Append To List     ${productName}    ${TempProductName}
                
                FOR  ${OptionVarian}  IN RANGE  1  ${totalOptionVariant+1}
                    Click Element    ${ProductOption.format(${Option},${OptionVarian})}
                END
                Click Element    ${AddToCartButtonInPLP.format(${Option})}
                Validate Message Success Alert Is Visible 
                    
                Open Minicart
                @{MinicartProductNameValue} =    Get Product Name From Minicart
                &{Arguments} =    Create Dictionary    productName=${productName}    MinicartProductNameValue=@{MinicartProductNameValue}
                Validate The Similarity Of Item Added To Cart    &{Arguments}
                Pass Execution    'Passed' 
            END
        END
    Fail
    


TCPLP4.Customers sort products
    [Tags]    plp    guest-user  
    #Sort by Low Price Asc
    Search Product by Keyword in Searchbox                  ${CategoryForSearch}
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Click Element    ${SortButton} 
    Click Element    ${SortOptionPrice} 
    Sorting Correct Validation  ${SortAsc}    ${productItemPrice.format(1)}   ${productItemPrice.format(2)}    ${productItemPrice.format(3)}
   
    #Sort by High Price Desc
    Wait Until Element Is Enabled    ${ButtonDescOption}
    Click Element    ${ButtonDescOption}
    Sorting Correct Validation  ${SortDesc}    ${productItemPrice.format(1)}   ${productItemPrice.format(2)}    ${productItemPrice.format(3)}
   
