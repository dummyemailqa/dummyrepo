*** Settings ***
Library      SeleniumLibrary
Library      Collections
Variables    ../resources/locators/login_locator.py
Variables    ../resources/locators/home_locator.py
Variables    ../resources/locators/my_account_locator.py


*** Keywords ***
To Login Page
    # Sleep    10
    Wait Until Element Is Visible   ${HeaderLinkToLogin}
    Click element   ${HeaderLinkToLogin}
    Wait Until Element Is Visible    ${ButtonSignIn}
    Click element   ${ButtonSignIn}
    Wait Until Element Is Visible    ${FromLogin}

Input Login Form
    [Arguments]    ${Email}    ${Password}
    Wait Until Element Is Enabled   ${LoginUsername}
    Input text  ${LoginUsername}    ${Email}
    Wait Until Element Is Enabled   ${LoginPassword}
    Input text  ${LoginPassword}    ${Password}

Submit Form Login
    Wait Until Element Is Enabled   ${ButtonLogin}
    Click element   ${ButtonLogin}

Login Validation
    Wait Until Element Is Visible    ${ButtonEditContactInformation}
    Element Should Be Visible   ${ButtonEditContactInformation} 