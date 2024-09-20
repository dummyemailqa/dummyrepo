*** Settings ***
Library         SeleniumLibrary
Library         Collections
Library         pabot.PabotLib
Variables       ../resources/locators/login_locator.py
Variables       ../resources/locators/home_locator.py
Variables       ../resources/locators/my_account_locator.py
Resource        ../base/common.robot
Resource        cart_page.robot


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
    ${isParallel}    Setup Account Data Set
    IF    ${isParallel}
        ${userEmail}    Get Value From Set    USERNAME
        ${userPassword}    Get Value From Set    PASSWORD
    ELSE
        ${userEmail}    Set Variable    ${EmailAddressRegistered}
        ${userPassword}    Set Variable    ${Password}
    END
    To Login Page
    Input Login Form    ${userEmail}    ${userPassword}
    Submit Form Login
    ${LoggedIn}    Login Validation
    Clear Customer Cart Items    ${userEmail}    ${userPassword}
    RETURN    ${LoggedIn}