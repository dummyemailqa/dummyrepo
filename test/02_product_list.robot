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
Resource    ../pages/product_list_page.robot

Test Setup          Start Test Case
Test Teardown       End Test Case



*** Keywords ***


*** Test Cases ***
TCPLP1.Customers able to Change product view as Grid on PLP
    [Tags]    plp
    # View as List
    Wait Until Element Is Visible in 10s    ${MenuWoman}
    CLick Element    ${MenuWoman}
    Wait Until Element Is Visible in 10s    ${ProductsListViewIcon}
    Click Element    ${ProductsListViewIcon}
    Wait Until Element Is Visible    ${ProductListViewContainer}
    Element Should Be Visible    ${ProductListViewContainer}

    # View as Grid
    Wait Until Element Is Visible in 10s    ${ProductsGridViewIcon}
    Click Element    ${ProductsGridViewIcon}
    Wait Until Page Contains Element    ${ProductGridViewContainer}

TCPLP2.Customers add product to the cart from PLP
    [Tags]    PLP  TCPLP2
    #search Product Simple by SKU
    Search Product by Keyword in Searchbox                  Ingrid Running Jacket
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Element Should Be Visible                               ${ProductItemCard}
    
    ${IsConfigurableProduct} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${VarianConfigurableInPLP}

    IF    ${IsConfigurableProduct}
      Click Element    xpath=(//button[contains(@class,'btn-primary') and contains(@aria-label,'Add to Cart')])[2]
    ELSE
      Click Element    xpath=(//button[contains(@class,'btn-primary') and contains(@aria-label,'Add to Cart')])[1]
    END
  
    Element Should Be Visible    ${SuccessAddToCartAllert}
    

TCPLP4.Customers sort products
    [Tags]    PLP  TCPLP4
    #Sort by Low Price
    Search Product by Keyword in Searchbox                  Women
    Element Should Be Visible                               ${ProductItemCard}
    Click Element    //select[@aria-label='Sort By']
    Click Element    //select[@aria-label='Sort By']//option[@value='price']
    Sorting Correct Validation  ${SortAsc}    ${productItemPrice.format(1)}   ${productItemPrice.format(2)}    ${productItemPrice.format(3)}
   

