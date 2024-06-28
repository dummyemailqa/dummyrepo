*** Settings ***
Library         SeleniumLibrary
Resource        ../base/common.robot
Resource        ../base/base.robot
Resource        ../pages/home_page.robot
Variables       ../resources/locators/product_list_locator.py

*** Keywords ***
Go To PDP Product By Index
    [Arguments]    ${index}
    Wait Until Element Is Visible With Long Time    ${ProductItemCardName.format(${index})}
    Click Element    ${ProductItemCardName.format(${index})}

Validate Search Product Is Simple Product
    [Arguments]    ${keyword}
    Search Product result Validation    ${keyword}
    ${IsProductInListingPage} =    Check If On Product Detail Page
    IF    not ${IsProductInListingPage}    Go To PDP Product By Index    1

Check If On Product Detail Page
    ${IsOnProductDetailPage} =    Run Keyword And Return Status    Element Should Be Visible    ${PLPProductName}
    RETURN    ${IsOnProductDetailPage}

Search Result Counter in PLP
    ${totalOption} =    Get Element Count    ${SummaryProductSearchResult}
    FOR    ${Option}    IN RANGE    1    ${totalOption+1}
            ${IsConfigurableProduct} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${VarianConfigurableInPLP}
        RETURN    ${Option}
        Exit For Loop If    ${VarianConfigurableInPLP}==TRUE
    END
 

