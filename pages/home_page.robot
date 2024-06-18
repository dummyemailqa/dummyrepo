*** Settings ***
Library         SeleniumLibrary
Library         Collections
Variables       ../resources/locators/home_locator.py
Variables       ../resources/locators/product_list_locator.py
Variables       ../resources/locators/product_detail_locator.py
Resource        ../base/common.robot
Resource        ../base/base.robot


*** Keywords ***
Search Product by Keyword in Searchbox
    [Arguments]    ${keyword}
    Click Element    ${SearchBox}
    Input Text    ${SearchBox}    ${keyword}
    Press Keys    None    ENTER

Search Product Suggestion Validation
    [Arguments]    ${keyword}
    ${txtProductSuggestion}    Get Text    ${SuggestedProduct}
    ${keyword}    Convert To Lower Case    ${keyword}
    ${txtProductSuggestion}    Convert To Lower Case    ${txtProductSuggestion}
    ${validasiProduct_name}    Run Keyword And Return Status    Should Contain    ${txtProductSuggestion}    ${keyword}
    IF    '${validasiProduct_name}'=='False'
        Run Keyword And Continue On Failure    Search Product Not Match    ${keyword}    ${txtProductSuggestion}
    END

Search Product result Validation
    [Arguments]    ${keyword}
    ${ShowPDP}    Run Keyword And Return Status    Wait Until Element Is Visible in 10s    ${PDPProductName}
    ${keyword}    Convert To Lower Case    ${keyword}
    IF    ${ShowPDP}
        Validate Message Success Alert Is Visible
        Wait Until Element Is Visible    ${TextSuggestedProduct}
        ${txtProductresult}    Get Text    ${TextSuggestedProduct}
        ${txtProductresult}    Convert To Lower Case    ${txtProductresult}
        ${validasiProduct_name}    Run Keyword And Return Status
        ...    Should Contain
        ...    ${txtProductresult}
        ...    ${keyword}
        IF    '${validasiProduct_name}'=='False'
            Run Keyword And Continue On Failure    Search Product Not Match    ${keyword}    ${txtProductresult}
        END
    ELSE
        ${txtProductresult}    Get Text    ${ProductItemCardName.format(1)}
        ${txtProductresult}    Convert To Lower Case    ${txtProductresult}
        ${validasiProduct_name}    Run Keyword And Return Status
        ...    Should Contain
        ...    ${txtProductresult}
        ...    ${keyword}
        IF    '${validasiProduct_name}'=='False'
            Run Keyword And Continue On Failure    Search Product Not Match    ${keyword}    ${txtProductresult}
        END
    END

Click On Product Suggestion
    [Arguments]    ${keyword}
    Clear Element Text    ${SearchBox}
    Click Element    ${SearchBox}
    Input Text    ${SearchBox}    ${keyword}
    Wait Until Element Is Visible With Long Time    ${SuggestedProduct}
    Search Product Suggestion Validation    ${keyword}
    Click Element    ${SuggestedProduct}

Get Text From Locator
    [Arguments]    ${Locator}
    Wait Until Element Is Visible With Long Time    ${Locator}
    ${Text}    Get Text    ${Locator}
    RETURN    ${Text}

Validate String contains
    [Arguments]    ${Argument1}    ${Argument2}
    ${Argument1}    Convert To Lower Case    ${Argument1}
    ${Argument2}    Convert To Lower Case    ${Argument2}
    ${contains}    Run Keyword And Return Status    Should Contain    ${Argument1}    ${Argument2}
    IF    '${contains}'=='False'    Fail

Validate Search Suggestions
    [Arguments]    ${keyword}
    Input Text    ${SearchBox}    ${keyword}
    Wait Until Element Is Visible With Long Time    ${SuggestedProduct}
    ${productname}    Get Text From Locator    ${SuggestedProduct}
    Validate String contains    ${productname}    ${keyword}

Get Product Name From PLP
    Wait Until Element Is Visible With Long Time    ${PLPProductName}
    ${PLPProductNameValue}    Get Text    ${PLPProductName}
    RETURN    ${PLPProductNameValue}

Change Currency
    Wait Until Element Is Visible                           ${ToggleCurrency}
    Click Element                                           ${ToggleCurrency}
    ${SelectedCurrency}    Get Text                         ${CurrencyItem}
    ${SelectedCurrency} =   Convert To Lower Case           ${SelectedCurrency}
    Wait Until Element Is Visible                           ${CurrencyItem}
    Click Element                                           ${CurrencyItem}
    Currency Validation                                     ${SelectedCurrency}

Currency Validation
    [Arguments]                                             ${SelectedCurrency}
    Wait Until Element Is Visible                           ${ProductPriceInHomePage}
    IF  '${BROWSER}'=="Safari"
        Press Keys    None    COMMAND+ARROW_DOWN
    ELSE
        Scroll Down To Element                              ${ProductPriceInHomePage}
    END
    ${ProductPriceCurrency}     Get Text                    ${ProductPriceInHomePage}
    ${ProductPriceCurrency} =   Convert To Lower Case       ${ProductPriceCurrency}
    IF  "${SelectedCurrency}"== "idr - indonesian rupiah" 
            Should Contain  ${ProductPriceCurrency}  rp
    ELSE IF    "${SelectedCurrency}" == "usd - us dollar"
            Should Contain  ${ProductPriceCurrency}  $
    ELSE
            Selected Currency Not Found    ${SelectedCurrency} 
    END

Selected Currency Not Found
    [Arguments]    ${SelectedCurrency}
    Fail    The currency(${SelectedCurrency}) data entered is not registered. Please update the Currency list data
