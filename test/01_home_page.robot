*** Settings ***
Documentation       Suite description
Variables           ../resources/locators/product_list_locator.py
Variables           ../resources/locators/base_locator.py
Variables           ../resources/locators/compare_locator.py
Variables           ../resources/locators/product_detail_locator.py
Variables           ../resources/data/testdata.py
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/home_page.robot
Resource            ../pages/login_page.robot
Resource            ../pages/compare_page.robot
Resource            ../pages/cart_page.robot
Test Setup          Start Test Case
Test Teardown       End Test Case

*** Test Cases ***
TCSe1.Search for Product Categories using Website's Search Box
    [Tags]    header    search
    Click On Category Suggestion    ${CategoryName}
    Search Category Product result Validation    ${CategoryName}

TCSe3.Successful Specific Product Search using Website's Search Box
    [Tags]    header    search
    # search Product Simple by SKU
    Search Product by Keyword in Searchbox    ${ProductSimpleSKUForSearch}
    Search Product result Validation    ${ProductSimpleNameForSearch}
    # search Product Simple by Name
    Clear Element Text    ${SearchBox}
    Search Product by Keyword in Searchbox    ${ProductSimpleNameForSearch}
    Search Product result Validation    ${ProductSimpleNameForSearch}


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

L-TCH1.Logged-in customers can access the Compare Product page
    [Tags]    header    compare
    Login User
    Empty the items in Compare Page
    
    Click Element    ${NavMenu2}
    ${PDPProductName1Value} =    Get Product Name From PLP
    Click Element    ${CompareButtonFirstProduct}
    Validate Message Success Alert Is Visible
    
    Click Element    ${NavMenu4}
    ${PDPProductName2Value} =    Get Product Name From PLP
    Click Element    ${CompareButtonFirstProduct}
    Validate Message Success Alert Is Visible
    
    Click Element    ${HeaderCompareButton}
    
    ${CompareProductName1Value} =    Get Text From Locator    ${CompareProductName1}
    ${CompareProductName2Value} =    Get Text From Locator    ${CompareProductName2}
    Validate The Similarity Of Item Added To Compare    ${PDPProductName1Value}    ${CompareProductName2Value}
    Validate The Similarity Of Item Added To Compare    ${PDPProductName2Value}    ${CompareProductName1Value}
    
G-TCH1.Guest customers can access the Compare Product page
    [Tags]    header    compare
    Click Element    ${NavMenu2}
    ${PDPProductName1Value} =    Get Product Name From PLP
    Click Element    ${CompareButtonFirstProduct}
    Validate Message Success Alert Is Visible
    Click Element    ${NavMenu4}
    ${PDPProductName2Value} =    Get Product Name From PLP
    Click Element    ${CompareButtonFirstProduct}
    Validate Message Success Alert Is Visible
    Click Element    ${HeaderCompareButton}
    ${CompareProductName1Value} =    Get Text From Locator    ${CompareProductName1}
    ${CompareProductName2Value} =    Get Text From Locator    ${CompareProductName2}
    Validate The Similarity Of Item Added To Compare    ${PDPProductName1Value}    ${CompareProductName2Value}
    Validate The Similarity Of Item Added To Compare    ${PDPProductName2Value}    ${CompareProductName1Value}

TCH3.Customers can access the header menu on the website
    # Guest User
    Open Minicart
    Close The Minicart
    Go To Home Page
    Open Compare Page
    Go To Home Page
    Change Currency
    Go To Home Page
    #LoggedIn User
    Login User
    Go To Home Page
    Open Minicart
    Close The Minicart
    Go To Home Page
    Open Compare Page
    Go To Home Page
    Change Currency