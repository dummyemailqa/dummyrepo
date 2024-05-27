*** Settings ***
Library         SeleniumLibrary
Variables       ../resources/data/testdata.py
Resource        ../base/common.robot
Resource        ../base/base.robot


*** Keywords ***
Error Item Added To Compare Not Match
    [Arguments]    ${Argument1}    ${Argument2}
    Fail
    ...    Data Nama Product yang ditambahkan dari pdp : -'${Argument1}'- tidak sesuai dengan data product di halaman Compare : -'${Argument2}'-

Validate The Similarity Of Item Added To Compare
    [Arguments]    ${Argument1}    ${Argument2}
    ${ValidateResult} =    Validate Similarity Of 2 Arguments    ${Argument1}    ${Argument2}
    IF    '${ValidateResult}'=='False'
        Run Keyword And Continue On Failure    Error Item Added To Compare Not Match    ${Argument1}    ${Argument2}
    END

Remove Products in Compare Page
    ${present}=     Run Keyword and Return Status           Wait Until Page Contains Element        ${BtnDeleteCompareItem}
    WHILE  ${present}
        Click Element                                       ${BtnDeleteCompareItem}
        Handle Alert    ACCEPT
        Sleep    5
        ${present}=     Run Keyword and Return Status       Wait Until Page Contains Element        ${BtnDeleteCompareItem}
    END
    Go To Home Page