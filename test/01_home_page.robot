*** Settings ***
Documentation   Suite description
Variables   ../resources/locators/product_list_locator.py
Variables   ../resources/locators/base_locator.py
Variables   ../resources/data/testdata.py
Resource    ../base/setup.robot
Resource    ../base/base.robot
Resource    ../base/common.robot
Resource    ../pages/home_page.robot

Test Setup  Start Test Case
Test Teardown    End Test Case

*** Test Cases ***

TCSe1.Search for Product Categories using Website's Search Box
    [Tags]    Header  Search
    #search Product Simple by SKU
    Search Product by Keyword in Searchbox                  ${ProductSimpleSKUForSearch}
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Element Should Be Visible                               ${ProductItemCard}
    Search Product result Validation by SKU                 ${ProductSimpleSKUForSearch}
    
    #search Product Simple by Name
    Clear Element Text                                      ${SearchBox}
    Search Product by Keyword in Searchbox                  ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Element Should Be Visible                               ${ProductItemCard}
    Search Product result Validation by Name                ${ProductSimpleNameForSearch}

    #search Product Suggestion
    Click On Product Suggestion                             ${ProductSimpleNameForSearch}
    Search Product result Validation by Name                ${ProductSimpleNameForSearch}