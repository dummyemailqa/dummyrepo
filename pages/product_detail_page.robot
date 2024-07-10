*** Settings ***
Library         SeleniumLibrary
Library         Collections
Resource        ../base/common.robot
Resource        ../base/base.robot
Resource        ../pages/home_page.robot
Resource        ../pages/product_list_page.robot
Variables       ../resources/locators/product_detail_locator.py
Variables       ../resources/locators/login_locator.py
Variables       ../resources/locators/my_account_locator.py
Variables       ../resources/locators/product_list_locator.py


*** Keywords ***
Input Item Qty
    [Arguments]    ${QTY}
    Wait Until Element Is Visible With Long Time    ${ProductQuantity}
    Clear Text Field    ${ProductQuantity}
    Input Text    ${ProductQuantity}    ${QTY}

Open Review Product Window
    Wait Until Element Is Visible With Long Time    ${PDPProductName}
    Scroll Down To Element    ${ProductReviewButton}
    Wait Until Element Is Visible With Long Time    ${ProductReviewButton}
    Click Element    ${ProductReviewButton}
    Wait Until Element Is Visible With Long Time    ${ReviewSubmitButton}

Input Review Product
    [Arguments]    ${Nickname}    ${Title}    ${Review}    ${Rate}
    Input Text    ${ReviewNameInput}    ${Nickname}
    IF    '${Rate}' != "0"
        Click Element    ${ReviewRatingButton.format(${Rate})}
    END
    Input Text    ${ReviewTitleInput}    ${Title}
    Input Text    ${ReviewDetailInput}    ${Review}
    Click Element    ${ReviewSubmitButton}

Cancel Review Product
    Wait Until Element Is Visible With Long Time    ${ReviewCancelSubmitButton}
    Click Element    ${ReviewCancelSubmitButton}
    Wait Until Element Is Not Visible    ${ReviewCancelSubmitButton}

Add To Wishlist From PDP
    Wait Until Element Is Visible With Long Time    ${ProductNameOnPDP}
    Scroll Down To Element    ${AddToWishListButton}
    Click Element    ${AddToWishListButton}

Validate Guest User Add To Wishlist
    Validate Message Error Alert Is Visible
    Wait Until Element Is Visible With Long Time    ${FromLogin}

Get Product Name From PDP
    Wait Until Element Is Visible With Long Time    ${ProductNameOnPDP}
    ${PDPProductNameValue} =    Get Text    ${ProductNameOnPDP}
    RETURN    ${PDPProductNameValue}

Go To PDP Product
    Wait Until Element Is Visible    ${ProductNameTitle}
    Click Element    ${ProductNameTitle}

Add To Cart
    [Arguments]    ${Qty}
    ${IsConfigurableProduct} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${ProductConfigurable}
    ${IsBundleProduct} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${ProductBundle}
    ${IsGroupProduct} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${ProductGroup}
    ${PDPProductNameValue} =    Get Product Name From PDP
    ${ProductNameList} =    Create List
    Append To List    ${ProductNameList}    ${PDPProductNameValue}
    IF    ${IsConfigurableProduct}
        Quantity Of Products    ${Qty}
        Select Configurable Product Option
    ELSE IF    ${IsBundleProduct}
        Customize Bundle Product
    ELSE IF    ${IsGroupProduct}
        Customize Group Product    ${ProductNameList}    ${Qty}
    ELSE
        Quantity Of Products    ${Qty}
    END
    IF    ${IsBundleProduct}
        Scroll Down To Element    ${AddToCartButtonBundle}
        Click Element    ${AddToCartButtonBundle}
    ELSE
        Scroll Down To Element    ${AddToCartButton}
        Click Element    ${AddToCartButton}
    END
    RETURN    ${ProductNameList}

Customize Group Product
    [Arguments]    ${ProductNameList}    ${Qty}
    Remove From List    ${ProductNameList}    -1
    ${totalItem} =    Get Element Count    ${ProductGroupOption}
    FOR    ${Item}    IN RANGE    1    ${totalItem+1}
        Clear Element Text    ${ProductGroupItem.format(${item})}
        Input Text    ${ProductGroupItem.format(${item})}    ${Qty}
        ${GroupProductChild} =    Get Text    ${GroupProductName.format(${Item})}
        Append To List    ${ProductNameList}    ${GroupProductChild}
    END

Select Configurable Product Option
    ${totalVarian} =    Get Element Count    ${TotalProductConfigurable}
    FOR    ${Varian}    IN RANGE    1    ${totalVarian+1}
        Click Element    ${ProductConfigurableOptionItem.format(${Varian})}
    END

Get Product Name From PDP ATC
    Wait Until Element Is Visible    ${PDPProductName}
    ${PDPProductNameValue} =    Get Text    ${PDPProductName}
    RETURN    ${PDPProductNameValue}

Quantity Of Products
    [Arguments]    ${qty}
    Wait Until Page Contains Element    ${QTYInput}
    Press Keys    ${QTYInput}    BACKSPACE
    Input Text    ${QTYInput}    ${qty}

Search Product Suggestion Validation PDP
    [Arguments]    ${keyword}
    Wait Until Element Is Visible    ${TextSuggestedProduct}
    ${txtProductSuggestion} =    Get Text    ${TextSuggestedProduct}
    ${keyword} =    Convert To Lower Case    ${keyword}
    ${txtProductSuggestion} =    Convert To Lower Case    ${txtProductSuggestion}
    ${validasiProduct_name} =    Run Keyword And Return Status
    ...    Should Contain
    ...    ${txtProductSuggestion}
    ...    ${keyword}
    IF    '${validasiProduct_name}'=='False'
        Run Keyword And Continue On Failure    Search Product Not Match    ${keyword}    ${txtProductSuggestion}
    END

Customize Bundle Product
    Click Element    ${BtnCutomizeProductBundle}
    Wait Until Element Is Not Visible    ${BtnCutomizeProductBundle}
    ${totalOption} =    Get Element Count    ${ProductBundleOption}
    FOR    ${Option}    IN RANGE    1    ${totalOption+1}
        Select Bundle Product Option    ${Option}
    END

Quantity Of Products Bundle Radio Options
    [Arguments]    ${qty}
    Wait Until Page Contains Element    ${QTYInputRadioBundle}
    FOR    ${index}    IN RANGE    0    ${qty}
        Click Element    ${QTYInputRadioBundle}
    END

Quantity Of Products Bundle Select Dropdown Options
    [Arguments]    ${qty}
    Wait Until Page Contains Element    ${QTYInputSelectBundle}
    FOR    ${index}    IN RANGE    0    ${qty}
        Click Element    ${QTYInputSelectBundle}
    END

Select Bundle Product Option
    [Arguments]    ${Option}
    ${option-select} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${ProductBundleOptionSelect.format(${Option})}
    ${option-select-dropdown} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${ProductBundleOptionSelectDropdown.format(${Option})}
    ${options-radio-container} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${ProductBundleOptionRadioContainer.format(${Option})}
    ${options-checkbox-container} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${ProductBundleOptionCheckboxContainer.format(${Option})}
    IF    ${${option-select}}
        Scroll Down To Element    ${ProductBundleOptionSelect.format(${Option})}
        Click Element    ${BtnProductBundleOptionSelect.format(${Option})}
    ELSE IF    ${${option-select-dropdown}}
        Scroll Down To Element    ${ProductBundleOptionSelectDropdown.format(${Option})}
        Click Element    ${BtnProductBundleOptionSelectDropdown.format(${Option})}
        Quantity Of Products Bundle Select Dropdown Options    1
    ELSE IF    ${options-radio-container}
        Scroll Down To Element    ${ProductBundleOptionRadioContainer.format(${Option})}
        Click Element    ${BtnRadioProductBundleOptionRadio.format(${Option})}
        Quantity Of Products Bundle Radio Options    1
    ELSE IF    ${${options-checkbox-container}}
        Scroll Down To Element    ${ProductBundleOptionCheckboxContainer.format(${Option})}
        Click Element    ${ProductBundleOptionCheckboxContainer.format(${Option})}
    END

Check If On Product Detail Page
    ${IsOnProductDetailPage} =    Run Keyword And Return Status    Element Should Be Visible    ${PDPProductName}
    RETURN    ${IsOnProductDetailPage}

Validate Search Product And Go To PDP
    [Arguments]    ${keyword}
    Search Product result Validation    ${keyword}
    ${IsOnProductDetailPage} =    Check If On Product Detail Page
    IF    not ${IsOnProductDetailPage}    Go To PDP Product By Index    1

Go To PDP Product By Index
    [Arguments]    ${index}
    Wait Until Element Is Visible With Long Time    ${ProductItemCardName.format(${index})}
    Click Element    ${ProductItemCardName.format(${index})}