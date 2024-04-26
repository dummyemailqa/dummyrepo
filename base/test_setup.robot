*** Settings ***
Library     SeleniumLibrary
Library     String
Variables   ../resources/data/testdata.py

*** Variables ***
${BROWSER}    Chrome
${CromeDriverPath}    ${CURDIR}/../../WebDrivers/chrome/chromedriver.exe
${EdgeDriverPath}    ${CURDIR}/../../WebDrivers/edge/msedgedriver.exe

*** Keywords ***
Start Test Case
    IF  '${BROWSER}'=='Chrome'
        ${BrowserConfiguration}    Set Variable    chrome_options
        ${ExecutablePath}    Set Variable    ${CromeDriverPath}
    ELSE IF  '${BROWSER}'=='Edge'
        ${BrowserConfiguration}    Set Variable    options
        ${ExecutablePath}    Set Variable    ${EdgeDriverPath}
    END
    Setup Browser Option Configuration    ${BrowserConfiguration}    ${ExecutablePath}
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
    Log To Console    "running on ${BROWSER}"