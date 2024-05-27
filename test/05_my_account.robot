*** Settings ***
Documentation       Suite description

Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../base/common.robot
Resource            ../pages/login_page.robot
Resource            ../pages/my_account_page.robot


Test Setup          Start Test Case
Test Teardown       End Test Case


*** Test Cases ***

L-TCMy1.Logged In User Can Edit Information
    To Login Page
    Input Login Form    ${EmailAddressRegistered}    ${Password}
    Submit Form Login
    My Account Page Validation    ${EmailAddressRegistered}
    To Account Information
    ${NewPhoneNumber}=    Generate Random Phonenumber
    ${NewWANumber}=    Generate Random Phonenumber
    Change Information        ${EditName}    ${EditLastName}   ${NewPhoneNumber}    ${NewWANumber}
    Save Information
    Validate Message Success Alert Is Visible

L-TCMy2.Logged In User Can Check History Order
    To Login Page
    Input Login Form                  ${EmailAddressRegistered}    ${Password}
    Submit Form Login
    My Account Page Validation        ${EmailAddressRegistered}
    To My Order

L-TCMy4.Logged In User Can Edit Account Information
    To Login Page
    Input Login Form                  ${EmailAddressRegistered}    ${Password}
    Submit Form Login
    My Account Page Validation        ${EmailAddressRegistered}
    To Account Information by Main Menu
    ${NewPhoneNumber}=    Generate Random Phonenumber
    ${NewWANumber}=    Generate Random Phonenumber
    Change Information        ${EditName}    ${EditLastName}   ${NewPhoneNumber}    ${NewWANumber}
    Save Information
    Validate Message Success Alert Is Visible

L-TCMy5.Logged In User Cannot Edit Account Information with Blank Fields
    To Login Page
    Input Login Form                  ${EmailAddressRegistered}    ${Password}
    Submit Form Login
    My Account Page Validation        ${EmailAddressRegistered}
    To Account Information by Main Menu
    #Validate Empty First Name
    Change Information        ${EMPTY}    ${LastName}   ${PhoneNumber}    ${PhoneNumber}
    Save Information
    Alert Warning Validation Register    ${AlertMessage}
    #Validate Empty Last Name
    Change Information        ${FirstName}    ${EMPTY}   ${PhoneNumber}    ${PhoneNumber}
    Save Information
    Alert Warning Validation Register    ${AlertMessage}
    #Validate Empty Phone Number
    Change Information        ${FirstName}    ${LastName}   ${EMPTY}    ${PhoneNumber}
    Save Information
    Alert Warning Validation Register    ${AlertMessage}
    #Validate Empty WA Number
    Change Information        ${FirstName}    ${LastName}   ${PhoneNumber}    ${EMPTY}
    Save Information
    Alert Warning Validation Register    ${AlertMessage}