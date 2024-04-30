*** Settings ***
Library      SeleniumLibrary
Library      Collections
Variables    ../resources/locators/login_locator.py
Variables    ../resources/locators/register_locator.py
Variables    ../resources/locators/home_locator.py

*** Keywords ***
To Register Page
    Wait Until Element Is Visible       ${HeaderLinkToLogin}
    Click element                       ${HeaderLinkToLogin}
    Wait Until Element Is Visible       ${ButtonRegister}
    Click Element                       ${ButtonRegister}
    Wait Until Element Is Visible       ${RegisterEmail}

Input Register Form
    [Arguments]    ${RegisterEmailR}    ${FirstNameR}    ${LastNameR}     ${PasswordR}    ${PasswordConfirmR}    ${PhoneNumberR}
    Input Text                                              ${RegisterEmail}                        ${RegisterEmailR}
    Input Text                                              ${RegisterFirstName}                    ${FirstNameR}
    Input Text                                              ${RegisterLastName}                     ${LastNameR}   
    Click Element                                           ${RegisterDateOfBirth}                  
    Click Element                                           ${ButtonTodayDayOfBirth}
    Input Text                                              ${RegisterPassword}                     ${PasswordR}
    Input Text                                              ${RegisterPasswordConfirmation}         ${PasswordConfirmR}
    Input Text                                              ${RegisterPhoneNumber}                  ${PhoneNumberR}
    Click Element                                           ${CheckBoxIsWhatsapp}
    Select Checkbox                                         ${RegisterSubscribeCheckbox}
