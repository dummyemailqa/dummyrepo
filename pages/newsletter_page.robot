*** Settings ***
Library         SeleniumLibrary
Resource        ../base/common.robot
Variables       ../resources/locators/newsletter_locator.py

*** Keywords ***
Input Email For Subcribe Newsletter
    [Arguments]    ${Email}
    Scroll Down To Element    ${InputEmailSubcribeNewsletter}
    Input Text    ${InputEmailSubcribeNewsletter}   ${Email}

Submit Subcribe Newsletter
    Wait Until Element Is Visible With Long Time    ${ButtonSubmitSubcribeNewsletter}
    Click Element    ${ButtonSubmitSubcribeNewsletter}