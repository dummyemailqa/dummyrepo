*** Settings ***
Documentation   Suite description
Variables   ../resources/locators/product_list_locator.py
Variables   ../resources/locators/base_locator.py
Variables   ../resources/locators/home_locator.py
Variables   ../resources/data/testdata.py
Resource    ../base/setup.robot
Resource    ../base/base.robot
Resource    ../base/common.robot
Resource    ../pages/home_page.robot

Test Setup  Start Test Case
Test Teardown    End Test Case

*** Test Cases ***
TCPLP1.Customers able to Change product view as Grid on PLP
    [Tags]    PLP  TCPLP1
    # View as List
    CLick Element    ${MenuWoman}
    Click Element    ${ProductsListViewIcon}
    Wait Until Page Contains Element    ${ProductListViewContainer}

    # View as Grid
    Click Element    ${ProductsGridViewIcon}
    Wait Until Page Contains Element    ${ProductGridViewContainer}

TCPLP2.Customers add product to the cart from PLP
    [Tags]    PLP  TCPLP2
    #search Product Simple by SKU
    Search Product by Keyword in Searchbox                  Ingrid Running Jacket
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Element Should Be Visible                               ${ProductItemCard}
    Click Element    //button[@class='btn-primary']/parent::div[@class='product-item-actions']
    Element Should Be Visible    //div[@ui-id='messages success']child::/div[@class='leading-none']
    
