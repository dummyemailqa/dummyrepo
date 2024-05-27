*** Settings ***
Library      SeleniumLibrary
Resource     ../base/base.robot

*** Keywords ***
Get Product Name From Minicart
    Wait Until Element Is Visible           ${MinicartProductName}
    ${MinicartProductNameValue}             Get Text                            ${MinicartProductName}
    RETURN    ${MinicartProductNameValue}

Error Item Added To Cart Not Match
    [Arguments]    ${Argument1}    ${Argument2}
    Fail
    ...    Data Nama Product yang ditambahkan ke kerangjang '${Argument1}' tidak sesuai dengan data product dikeranjang : ${Argument2}

Validate The Similarity Of Item Added To Cart
    [Arguments]    ${Argument1}    ${Argument2}
    ${ValidateResult}    Validate Similarity Of 2 Arguments    ${Argument1}    ${Argument2}
    IF    '${ValidateResult}'=='False'
        Run Keyword And Continue On Failure    Error Item Added To Cart Not Match    ${Argument1}    ${Argument2}
    END