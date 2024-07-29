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

Check If On Product Listing Page
    ${IsProductInListingPage} =    Run Keyword And Return Status    Element Should Be Visible    ${PLPProductName}
    RETURN    ${IsProductInListingPage}

# Search Result Counter in PLP
#     ${totalOption} =    Get Element Count    ${SummaryProductSearchResult}
#     FOR    ${Option}    IN RANGE    1    ${totalOption+1}
#             ${IsConfigurableProduct} =    Run Keyword And Return Status
#     ...    Wait Until Element Is Visible
#     ...    ${VarianConfigurableInPLP}
#         RETURN    ${Option}
#         Exit For Loop If    ${VarianConfigurableInPLP}==TRUE
#     END
 
Sorting Correct Validation
    [Arguments]                                                 ${sort_by}  ${product_item_1}  ${product_item_2}  ${product_item_3}
    Execute Javascript                                          window.scrollTo(0, 200)
    ${ProductItem1}                 Get Text                    ${product_item_1}
    ${ProductItem2}                 Get Text                    ${product_item_2}
    ${ProductItem3}                 Get Text                    ${product_item_3}
    @{products}=    Create List    ${ProductItem1}    ${ProductItem2}    ${ProductItem3}
    IF  "${sort_by}" == "ASC"
        Log    "array product:"
        Log      ${products}
        ${SortedASC}    Execute Javascript      const asc = (b, i, { [i - 1]: a }) => !i || a <= b, array_asc = ${products}; return array_asc.every(asc);
        Log      ${SortedASC}
        Should Be True                  ${SortedASC}
    ELSE IF  "${sort_by}" == "DESC"
        Log    "array product:"
        Log      ${products}
        ${SortedDESC}    Execute Javascript      const desc = (b, i, { [i - 1]: a }) => !i || a >= b, array_desc = ${products};return array_desc.every(desc);
        Log      ${SortedDESC}
        Should Be True                  ${SortedDESC}
    END

Click Category Menu by Index  
     [Arguments]   ${CategoryIndex}
    Wait Until Element Is Visible in 10s    ${CategoryMenuByIndex.format(${CategoryIndex})}
    Wait Until Element Is Enabled    ${CategoryMenuByIndex.format(${CategoryIndex})}
    CLick Element    ${CategoryMenuByIndex.format(${CategoryIndex})}

View Products as List in PLP
    Wait Until Element Is Visible in 10s    ${ProductsListViewIcon}
    Click Element    ${ProductsListViewIcon}
    Wait Until Element Is Visible in 10s     ${ProductListViewContainer}

View Products Grid in PLP
    Wait Until Element Is Visible in 10s    ${ProductsGridViewIcon}
    Click Element   ${ProductsGridViewIcon}
    Wait Until Element Is Visible in 10s    ${ProductGridViewContainer}