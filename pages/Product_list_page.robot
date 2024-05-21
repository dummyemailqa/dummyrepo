*** Settings ***
Library         SeleniumLibrary
Resource        ../base/common.robot
Resource        ../base/base.robot
Variables       ../resources/locators/product_list_locator.py

*** Keywords ***
Go To PDP Product By Index
    [Arguments]    ${index}
    Wait Until Element Is Visible With Long Time    ${ProductItemCardName.format(${index})}
    Click Element    ${ProductItemCardName.format(${index})}