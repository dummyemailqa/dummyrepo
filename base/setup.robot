*** Settings ***
Library     SeleniumLibrary
Library     String
Variables   ../resources/data/testdata.py

*** Variables ***
${BROWSER}    Safari
${CromeDriverPath}    ${CURDIR}/../../chromedriver-mac-x64/chromedriver
${EdgeDriverPath}    ${CURDIR}/../../edgedriver_mac64/msedgedriver

*** Keywords ***
Start Test Case
    ${OS}=    Evaluate    platform.system()    platform
    Log    "running on ${OS}-${BROWSER}"
    @{Browser_id}=                                          Get Browser Ids
    Run Keyword if                                          @{Browser_id}==[]                   Start Test

Start Test
    IF  '${BROWSER}'=='Chrome'
        ${BrowserConfiguration}    Set Variable    chrome_options
        ${ExecutablePath}    Set Variable    ${CromeDriverPath}
        Setup Browser Option Configuration    ${BrowserConfiguration}    ${ExecutablePath}
    ELSE IF  '${BROWSER}'=='Edge'
        ${BrowserConfiguration}    Set Variable    options
        ${ExecutablePath}    Set Variable    ${EdgeDriverPath}
        Setup Browser Option Configuration    ${BrowserConfiguration}    ${ExecutablePath}

    ELSE IF  '${BROWSER}'=='Safari'
        ${BrowserConfiguration}    Set Variable    options
        Create WebDriver    ${BROWSER}
        Maximize Browser Window
    END
    Go to   ${URLWEB}
    Execute JavaScript    document.body.style.zoom = "100%"
    Set selenium speed  1    

Setup Browser Option Configuration
    [Arguments]    ${BrowserConfiguration}    ${ExecutablePath}
    ${options}=  Evaluate  sys.modules['selenium.webdriver'].${BROWSER}Options()  sys, selenium.webdriver
    Call Method    ${options}    add_argument    --disable-extensions
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    window-size\=1920,1080
    ${options.prefs}    Create Dictionary    profile.default_content_setting_values.geolocation     1
    Call Method    ${options}    add_experimental_option    prefs       ${options.prefs}
    Create WebDriver    ${BROWSER}    ${BrowserConfiguration}=${options}   executable_path=${ExecutablePath}
