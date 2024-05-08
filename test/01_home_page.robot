*** Settings ***
Documentation   Suite description
Variables   ../resources/locators/product_list_locator.py
Variables   ../resources/locators/base_locator.py
Variables   ../resources/data/testdata.py
Resource    ../base/test_setup.robot
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
    
    #search Product Simple by Name
    Clear Element Text                                      ${SearchBox}
    Search Product by Keyword in Searchbox                  ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Element Should Be Visible                               ${ProductItemCard}

    #search Product Suggestion
    Click On Product Suggestion                             ${ProductSimpleNameForSearch}

TCSe3.Successful Specific Product Search using Website's Search Box
    [Tags]    Header  Search
    #search Product Simple by SKU
    Search Product by Keyword in Searchbox                  ${ProductSimpleSKUForSearch}
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Element Should Be Visible                               ${ProductItemCard}

    #search Product Simple by Name
    Clear Element Text                                      ${SearchBox}
    Search Product by Keyword in Searchbox                  ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Element Should Be Visible                               ${ProductItemCard}

TCSe4.Validation of Unsuccessful Product Search with Random Characters Appended to Product Name
    [Tags]    Header  Search
    #search Product Simple by SKU
    Search Product by Keyword in Searchbox                  ${ProductSimpleSKUWithRandomCharacter}
    Wait Until Element Is Visible With Long Time            ${AlertProductNotFound}
    Element Should Be Visible                               ${AlertProductNotFound}
   
    #search Product Simple by Name
    Clear Element Text                                      ${SearchBox}
    Search Product by Keyword in Searchbox                  ${ProductSimpleNameWithRandomCharacter}
    Wait Until Element Is Visible With Long Time            ${AlertProductNotFound}
    Element Should Be Visible                               ${AlertProductNotFound}

TCSe5.Validation of Successful Product Search with Special Characters Appended to Product Name
    [Tags]    Header  Search
    #search Product Simple by SKU
    Search Product by Keyword in Searchbox                  ${ProductSpecialSKUForSearch}
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Element Should Be Visible                               ${ProductItemCard}
   
    #search Product Simple by Name
    Clear Element Text                                      ${SearchBox}
    Search Product by Keyword in Searchbox                  ${ProductSpecialNameForSearch}
    Wait Until Element Is Visible With Long Time            ${ProductItemCard}
    Element Should Be Visible                               ${ProductItemCard}