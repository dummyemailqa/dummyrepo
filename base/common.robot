*** Settings ***
Library         SeleniumLibrary
Library         String
Library         pabot.PabotLib
Variables       ../resources/data/testdata.py
Variables       ../resources/locators/base_locator.py
Variables       ../resources/locators/cart_page_locator.py
Resource        ../base/base.robot


*** Keywords ***
Alert Success Validation
    Wait Until Element Is Visible With Long Time  ${MessageSuccessAlert}
    Click Element    ${CloseMessageBtn}

Wait Until Element Is Visible With Long Time
    [Arguments]    ${Element}
    Wait Until Element Is Visible    ${Element}    45

Wait Until Element Is Visible in 10s
    [Arguments]    ${Element}
    Wait Until Element Is Visible    ${Element}    10

Wait Until Element Is Not Visible With Long Time
    [Arguments]    ${Element}
    Wait Until Element Is Not Visible    ${Element}    45

Alert Warning Validation Register
    [Arguments]    ${AlertMessage}
    Wait Until Element Is Visible    ${AlertMessage}

Setup Account Data Set
    TRY
        Acquire Lock    AccountLock
        Release Lock    AccountLock
        Acquire Value Set    user
        RETURN    ${True}
    EXCEPT
        Log    Failed Acquire Value Set
        RETURN    ${False}
    END

Wait Until Element Is Disabled
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds    10    0.3    Element Attribute Should Be Disabled    ${locator}

Element Attribute Should Be Disabled
    [Arguments]    ${locator}
    ${is_enabled}=    Get Element Attribute    ${locator}    disabled
    Run Keyword If    '${is_enabled}'=='None'    Fail    Element '${locator}' is still enabled