*** Settings ***
Documentation       Suite description

Variables           ../resources/locators/product_list_locator.py
Variables           ../resources/locators/base_locator.py
Variables           ../resources/locators/compare_locator.py
Variables           ../resources/data/testdata.py
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/home_page.robot
Resource            ../pages/compare_page.robot

Test Setup          Start Test Case
Test Teardown       End Test Case


*** Test Cases ***
TCSe1.Search for Product Categories using Website's Search Box
    [Tags]    header    search
    # search Product Simple by SKU
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible    ${ProductItemCard}
    Search Product result Validation by SKU    ${ProductSimpleSKUForSearch}

    # search Product Simple by Name
    Clear Element Text    ${SearchBox}
    Search Product by Keyword in Searchbox    ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible    ${ProductItemCard}
    Search Product result Validation by Name    ${ProductSimpleNameForSearch}

    # search Product Suggestion
    Click On Product Suggestion    ${ProductSimpleNameForSearch}
    Search Product result Validation by Name    ${ProductSimpleNameForSearch}

TCSe3.Successful Specific Product Search using Website's Search Box
    [Tags]    header    search
    # search Product Simple by SKU
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible    ${ProductItemCard}

    # search Product Simple by Name
    Clear Element Text    ${SearchBox}
    Search Product by Keyword in Searchbox    ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible    ${ProductItemCard}

TCSe4.Validation of Unsuccessful Product Search with Random Characters Appended to Product Name
    [Tags]    header    search
    # search Product Simple by SKU
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUWithRandomCharacter}
    Wait Until Element Is Visible With Long Time    ${AlertProductNotFound}
    Element Should Be Visible    ${AlertProductNotFound}

    # search Product Simple by Name
    Clear Element Text    ${SearchBox}
    Search Product by Keyword in Searchbox    ${ProductSimpleNameWithRandomCharacter}
    Wait Until Element Is Visible With Long Time    ${AlertProductNotFound}
    Element Should Be Visible    ${AlertProductNotFound}

TCSe5.Validation of Successful Product Search with Special Characters Appended to Product Name
    [Tags]    header    search
    # search Product Simple by SKU
    Search Product by Keyword in Searchbox    ${ProductSpecialSKUForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible    ${ProductItemCard}

    # search Product Simple by Name
    Clear Element Text    ${SearchBox}
    Search Product by Keyword in Searchbox    ${ProductSpecialNameForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible    ${ProductItemCard}

G-TCH1.Guest customers can access the "Compare Product" page
    Click Element    ${NavMenu2}
    ${PDPProductName1Value} =    Get Product Name From PLP
    Click Element    ${CompareButtonFirstProduct}
    Validate Message Success Alert Is Visible
    Click Element    ${NavMenu4}
    ${PDPProductName2Value} =    Get Product Name From PLP
    Click Element    ${CompareButtonFirstProduct}
    Validate Message Success Alert Is Visible
    Click Element    //a[@id="compare-link"]
    ${CompareProductName1Value} =    Get Text From Locator    ${CompareProductName1}
    ${CompareProductName2Value} =    Get Text From Locator    ${CompareProductName2}
    Validate The Similarity Of Item Added To Compare    ${PDPProductName1Value}    ${CompareProductName2Value}
    Validate The Similarity Of Item Added To Compare    ${PDPProductName2Value}    ${CompareProductName1Value}
