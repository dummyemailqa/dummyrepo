*** Settings ***
Library         SeleniumLibrary
Library         Collections
Variables       ../resources/data/testdata.py
Variables       ../resources/locators/my_account_locator.py
Variables       ../resources/locators/home_locator.py
Variables       ../resources/locators/register_locator.py
Resource        ../base/common.robot
Resource        ../base/base.robot


*** Keywords ***
To My Wishlist From User Menu
    Wait Until Element Is Visible    ${UserLoggedInIcon}
    Click Element    ${UserLoggedInIcon}
    Wait Until Element Is Enabled    ${CustomerMenuWishlist}
    Click Element    ${CustomerMenuWishlist}
    Wait Until Element Is Visible With Long Time    ${WishlishPage}

To My Wishlist From Nav Bar
    Wait Until Element Is Visible With Long Time    ${MyWishlistMenu}
    Click Element    ${MyWishlistMenu}
    Wait Until Element Is Visible With Long Time    ${WishlishPage}

Emty Item In Wishlish Page
    To My Wishlist From Nav Bar
    ${present}=    Run Keyword and Return Status
    ...    Wait Until Element Is Visible With Long Time
    ...    ${DeleteWishlistItemButton}
    WHILE    ${present}
        Wait Until Element Is Visible With Long Time    ${DeleteWishlistItemButton}
        Scroll Down To Element    ${DeleteWishlistItemButton}
        Click Element    ${DeleteWishlistItemButton}
        Validate Message Success Alert Is Visible
        ${WishlistItemIsEmty}=
        ...    Run Keyword and Return Status
        ...    Wait Until Element Is Visible
        ...    ${MessageInfoEmty}
        IF    ${WishlistItemIsEmty}    BREAK
        ${present}=    Run Keyword and Return Status
        ...    Wait Until Element Is Visible With Long Time
        ...    ${DeleteWishlistItemButton}
    END

Get Product Name From Wishlish Page
    Wait Until Element Is Visible With Long Time    ${WishlistPageProductName}
    ${ProductNameValue}=    Get Text    ${WishlistPageProductName}
    RETURN    ${ProductNameValue}

Error Item Added To Wishlist Not Match
    [Arguments]    ${Argument1}    ${Argument2}
    Fail
    ...    Data Nama Product yang ditambahkan dari pdp : -'${Argument1}'- tidak sesuai dengan data product di halaman Wishlist : -'${Argument2}'-

Validate The Similarity Of Item Added To Wishlist
    [Arguments]    ${Argument1}    ${Argument2}
    ${ValidateResult}=    Validate Similarity Of 2 Arguments    ${Argument1}    ${Argument2}
    IF    '${ValidateResult}'=='False'
        Run Keyword And Continue On Failure    Error Item Added To Wishlist Not Match    ${Argument1}    ${Argument2}
    END

My Account Page Validation
    [Arguments]    ${keyword}
    ${txtMyAccountEmail}    Get Text    ${MyAccountEmail}
    ${keyword}    Convert To Lower Case    ${keyword}
    ${txtMyAccountEmail}    Convert To Lower Case    ${txtMyAccountEmail}
    ${validasiEmail_Name}    Run Keyword And Return Status    Should Contain    ${txtMyAccountEmail}    ${keyword}
    IF    '${validasiEmail_Name}'=='False'
        Run Keyword And Continue On Failure    Search Product Not Match    ${keyword}    ${txtMyAccountEmail}
    END 

To Account Information 
    Click Element                                               ${ChangeInfoBtn}

Change Information With Args
    [Arguments]                                                 ${FirstName}    ${last_name}    ${PhoneNumber}    ${WhatsAppNumber} 
    Wait Until Element Is Visible With Long Time                ${SaveInfoBtn}
    Clear Text Field                                            ${RegisterFirstName}
    Input Text                                                  ${RegisterFirstName}            ${FirstName}
    Clear Text Field                                            ${RegisterLastName}     
    Input Text                                                  ${RegisterLastName}             ${last_name}
    Clear Text Field                                            ${RegisterPhoneNumber}
    Input Text                                                  ${RegisterPhoneNumber}          ${PhoneNumber}
    Unselect Phone Number Is Registered In WhatsApp
    Clear Text Field                                            ${InfoWhatsAppNumber}
    Input Text                                                  ${InfoWhatsAppNumber}       ${WhatsAppNumber}

Change Information 
    [Arguments]                                                 ${FirstName}    ${last_name}    ${PhoneNumber}    ${WhatsAppNumber}
    Change Information With Args                                ${FirstName}    ${last_name}    ${PhoneNumber}    ${WhatsAppNumber}      

Unselect Phone Number Is Registered In WhatsApp
    ${Status}=     Run Keyword And Return Status                Checkbox Should Be Selected    ${RegisterWhatsappCheckbox}
    IF    ${Status}    
        Click Element                                           ${RegisterWhatsappCheckbox}
        Wait Until Element Is Visible With Long Time            ${InfoWhatsAppNumber}
    END

Save Information
    Execute Javascript    window.scrollTo(0, 500)
    Click Element                                               ${SaveInfoBtn}

To My Order 
    Wait Until Element Is Visible With Long Time                ${MyOrdersMenu}
    Click Element                                               ${MyOrdersMenu}
    Wait Until Element Is Visible With Long Time                ${MyOrderPage}
    Element Should Be Visible                                   ${MyOrderPage}

To Account Information by Main Menu
    Wait Until Element Is Visible With Long Time                ${AccountInformationMenu}
    Click Element                                               ${AccountInformationMenu}

Change Phone Number and Whatsapp Number
    [Arguments]                                                 ${PhoneNumber}            ${WhatsAppNumber} 
    Wait Until Element Is Visible With Long Time                ${SaveInfoBtn}
    Clear Text Field                                            ${RegisterPhoneNumber}
    Input Text                                                  ${RegisterPhoneNumber}    ${PhoneNumber}
    Unselect Phone Number Is Registered In WhatsApp
    Clear Text Field                                            ${InfoWhatsAppNumber}
    Input Text                                                  ${InfoWhatsAppNumber}     ${WhatsAppNumber}

To My Product Review
    Wait Until Element Is Visible With Long Time                ${MyProductReviewMenu}
    Click Element                                               ${MyProductReviewMenu}
    Wait Until Element Is Visible With Long Time                ${MyProductReviewPage}
    Element Should Be Visible                                   ${MyProductReviewPage}

To Store Credit & Refund
    Wait Until Element Is Visible With Long Time                ${StoreCreditMenu}
    Click Element                                               ${StoreCreditMenu}
    Wait Until Element Is Visible With Long Time                ${StoreCreditPage}
    Element Should Be Visible                                   ${StoreCreditPage}

To Reward Points
    Wait Until Element Is Visible With Long Time                ${RewardPointsMenu}
    Click Element                                               ${RewardPointsMenu}
    Wait Until Element Is Visible With Long Time                ${RewardPointsPage}
    Element Should Be Visible                                   ${RewardPointsPage}

To Newsletter Subscriptions Page
    Wait Until Element Is Visible With Long Time                ${NewsletterMenu}
    Click Element                                               ${NewsletterMenu}
    Wait Until Element Is Visible With Long Time                ${NewsletterCheckBox}
    Element Should Be Visible                                   ${NewsletterCheckBox}

Subcribe Newsletter Subscriptions
    ${Status}=     Run Keyword And Return Status                Checkbox Should Be Selected    ${NewsletterCheckBox}
    IF    ${Status}    
        Click Element                                           ${NewsletterCheckBox}
        Click Element                                           ${SaveInfoBtn}
        Wait Until Element Is Visible With Long Time            ${MessageSuccessAlert}
        To Newsletter Subscriptions Page
    END
    Click Element                                           ${NewsletterCheckBox}
    Click Element                                           ${SaveInfoBtn}
    Wait Until Element Is Visible With Long Time            ${MessageSuccessAlert}

UnSubcribe Newsletter Subscriptions
    ${Status}=     Run Keyword And Return Status                Checkbox Should Not Be Selected    ${NewsletterCheckBox}
    IF    ${Status}    
        Click Element                                           ${NewsletterCheckBox}
        Click Element                                           ${SaveInfoBtn}
        Wait Until Element Is Visible With Long Time            ${MessageSuccessAlert}
        To Newsletter Subscriptions Page
    END
    Click Element                                           ${NewsletterCheckBox}
    Click Element                                           ${SaveInfoBtn}
    Wait Until Element Is Visible With Long Time            ${MessageSuccessAlert}

To Gift Card Page
    Wait Until Element Is Visible With Long Time                ${GiftCardMenu}
    Click Element                                               ${GiftCardMenu}
    Wait Until Element Is Visible With Long Time                ${GiftcardCheckStatusandBalanceButton}
    Element Should Be Visible                                   ${GiftcardCheckStatusandBalanceButton}

Submit Gift Card Code Manually
    [Arguments]    ${Argument}
    Input Text                                                  ${EnterGiftCardCode}    ${Argument}
    Click Element                                               ${GiftcardCheckStatusandBalanceButton}

Validation of Gift Card from the My Account page
    #Validate Gift Card Code
    [Arguments]    ${Keyword}
    ${valueGiftCode}    Get Text    ${GiftCardCodeInformation}
    ${Keyword}    Convert To Lower Case    ${GiftCardCodeManually}
    ${valueGiftCode}    Convert To Lower Case    ${valueGiftCode}
        ${ValidateResultCode}=        Validate Similarity Of 2 Arguments    ${valueGiftCode}    ${Keyword}
            IF    '${ValidateResultCode}'=='False'
                Run Keyword And Continue On Failure   Error To Gift Card Not Match   ${Keyword}    ${valueGiftCode}
            END
    #Validate Gift Card Amount
    ${valueAmountGiftCard}=    Get Text    ${BalanceGiftcardAmount}
        ${ValidateResultAmount}=    Validate Similarity Of 2 Arguments    ${valueAmountGiftCard}    Rp 100,000.00
            IF    '${ValidateResultAmount}'=='False'
                Run Keyword And Continue On Failure   Error To Gift Card Not Match   ${valueAmountGiftCard}    Rp 100,000.00
            END
            
Error To Gift Card Not Match
    [Arguments]    ${Argument1}    ${Argument2}
    Fail
    ...    Value Kode Giftcard Tidak Sesuai Antara : -'${Argument1}'- Dengan : -'${Argument2}'-