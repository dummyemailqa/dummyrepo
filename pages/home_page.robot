*** Settings ***
Library      SeleniumLibrary
Library      Collections
Variables    ../resources/locators/home_locator.py
Variables    ../resources/locators/product_list_locator.py
Resource    ../base/common.robot
Resource    ../base/base.robot


*** Keywords ***
Search Product by Keyword in Searchbox
    [Arguments]    ${keyword}
    Click Element                                           ${SearchBox}
    Input Text                                              ${SearchBox}                      ${keyword}
    Press Keys                                              None                              ENTER

Search Product Suggestion Validation
    [Arguments]    ${keyword}
    ${txtProductSuggestion}     Get Text                    ${SuggestedProduct}
    ${keyword} =                Convert To Lower Case       ${keyword}
    ${txtProductSuggestion} =   Convert To Lower Case       ${txtProductSuggestion}
    ${validasiProduct_name}    Run Keyword And Return Status    Should Contain    ${txtProductSuggestion}    ${keyword}
    IF  '${validasiProduct_name}'=='False'               
        Run Keyword And Continue On Failure   Search Product Not Match    ${keyword}    ${txtProductSuggestion}
    END

Search Product result Validation by Name
    [Arguments]    ${keyword}
    ${txtProductresult}         Get Text                    ${ProductItemCardName}
    ${keyword} =                Convert To Lower Case       ${keyword}
    ${txtProductSuggestion} =   Convert To Lower Case       ${txtProductresult}
    ${validasiProduct_name}    Run Keyword And Return Status    Should Contain    ${txtProductSuggestion}    ${keyword}
    IF  '${validasiProduct_name}'=='False'               
        Run Keyword And Continue On Failure   Search Product Not Match    ${keyword}    ${txtProductresult}
    END

Search Product result Validation by SKU
    [Arguments]    ${keyword}
    ${txtProductresult}         Get Text                    ${ProductItemCardName}
    ${keyword} =                Convert To Lower Case       ${ProductSimpleNameForSearch}
    ${txtProductSuggestion} =   Convert To Lower Case       ${txtProductresult}
    ${validasiProduct_name}    Run Keyword And Return Status    Should Contain    ${txtProductSuggestion}    ${keyword}
    IF  '${validasiProduct_name}'=='False'               
        Run Keyword And Continue On Failure   Search Product Not Match    ${keyword}    ${txtProductresult}
    END

Click On Product Suggestion
    [Arguments]    ${keyword}
    Clear Element Text                                      ${SearchBox}
    Click Element                                           ${SearchBox}
    Input Text                                              ${SearchBox}                      ${keyword}
    Wait Until Element Is Visible With Long Time            ${SuggestedProduct}
    Search Product Suggestion Validation                    ${keyword}
    Click Element                                           ${SuggestedProduct}

Get Text From Locator
    [Arguments]    ${Locator}
    Wait Until Element Is Visible With Long Time            ${Locator}
    ${Text}                                                 Get Text                        ${Locator}
    RETURN    ${Text}

Validate String contains
    [Arguments]      ${Argument1}       ${Argument2}
    ${Argument1} =       Convert To Lower Case              ${Argument1}
    ${Argument2} =       Convert To Lower Case              ${Argument2}
    ${contains}=    Run Keyword And Return Status    Should Contain    ${Argument1}   ${Argument2}
    IF  '${contains}'=='False'               
        Fail
    END

validate Search Suggestions
    [Arguments]    ${keyword}
    Input Text                                              ${SearchBox}                      ${keyword}
    Wait Until Element Is Visible With Long Time            ${SuggestedProduct}
    ${productname}=    Get Text From Locator                ${SuggestedProduct}
    Validate String contains       ${productname}    ${keyword}