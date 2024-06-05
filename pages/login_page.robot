*** Settings ***
Library         SeleniumLibrary
Library         Collections
Variables       ../resources/locators/login_locator.py
Variables       ../resources/locators/home_locator.py
Variables       ../resources/locators/my_account_locator.py
Resource        ../base/common.robot


*** Keywords ***
To Login Page
    Wait Until Element Is Visible With Long Time    ${HeaderLinkToLogin}
    Click Element    ${HeaderLinkToLogin}
    Wait Until Element Is Visible With Long Time    ${ButtonSignIn}
    Click element    ${ButtonSignIn}
    Wait Until Element Is Visible    ${FromLogin}

Input Login Form
    [Arguments]    ${Email}    ${Password}
    Wait Until Element Is Enabled    ${LoginUsername}
    Input text    ${LoginUsername}    ${Email}
    Wait Until Element Is Enabled    ${LoginPassword}
    Input text    ${LoginPassword}    ${Password}

Submit Form Login
    Wait Until Element Is Enabled    ${ButtonLogin}
    Click element    ${ButtonLogin}

Login Validation
    Wait Until Element Is Visible    ${ButtonEditContactInformation}
    Element Should Be Visible    ${ButtonEditContactInformation}

Go To Login By Phone Number
    Wait Until Element Is Visible With Long Time    ${ButtonSwitchLoginByPhoneNumber}
    Click Element    ${ButtonSwitchLoginByPhoneNumber}

Input Phone Number Login Form
    [Arguments]    ${PhoneNumber}
    Wait Until Element Is Visible With Long Time    ${LoginPhoneNumber}
    Input Text    ${LoginPhoneNumber}    ${PhoneNumber}

Submit Request OTP
    Wait Until Element Is Visible With Long Time    ${ButtonRequestOTP}
    Click Element    ${ButtonRequestOTP}

Login User
    To Login Page
    Input Login Form    ${EmailAddressRegistered}    ${Password}
    Submit Form Login
    ${LoggedIn}    Login Validation
    RETURN    ${LoggedIn}