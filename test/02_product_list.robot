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

Test Setup  Start Test Case
Test Teardown    End Test Case

*** Keywords ***
Remove Letters
    [Arguments]    ${text}
    ${cleaned_text}=    Regexp Replace    ${text}    [^\d.]    ${EMPTY}
    [Return]    ${cleaned_text}

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
    

TCPLP4.Customers sort products
    [Tags]    PLP  TCPLP4
    #Sort by Low Price
    Search Product by Keyword in Searchbox                  Women
    Element Should Be Visible                               ${ProductItemCard}
    Click Element    //select[@aria-label='Sort By']
    Click Element    //select[@aria-label='Sort By']//option[@value='price']
    ${price1}=    Get Value    //span[@data-]
    ${price1}=    Remove Letters    ${price1}
    Log To Console    ${price1}
    ${price1}=    Convert To Number    ${price1}
    
    ${price2}=    Get Text    //main[@id='maincontent']//form[2]//span[@class='price']
    ${price2}=    Replace String    ${price1}    'Rp '    ''
    ${price2}=    Convert To Number    ${price2}
    
    ${price3}=    Get Text    //main[@id='maincontent']//form[3]//span[@class='price']
    ${price3}=    Replace String    ${price1}    'Rp '    ${null}    
    ${price3}=    Convert To Number    ${price3}
    Pass Execution if(${price1} <= ${price2} <= ${price3})
