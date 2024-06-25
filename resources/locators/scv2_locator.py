
#login
ButtonCheckoutogInSCV       = "//button[@id='checkout-login-continueButton']"
InputPhoneNumberLogin       = "//input[@id='checkout-loginPhoneNumber-textField']"
AlertMessageLoginFaild      = "//p[contains(@class,'textField-errorLabel')]"
InputOTPLogin               = "//input[@id='checkout-loginOtp-textField']"

#address
SCVAddAddressWhileBlank     = "//img[@class='checkout-shipping-pin-img']"
SCVSaveNewAddress           = "//button[@id='checkout-address-saveButton']"
SendWAOTPButton             = "//div[@role='button']"
SCVOTPField                 = "//input[@name='otp']"
SCVContinueToCheckout       = "//button[@id='checkout-login-continueButton']"
SCVErrorMessageAddressBlank = "//div[contains(@class,'MuiInputBase-root Mui-error')]"
SCVPinpointBlank            = "//div[contains(@class,'column-pinpoint')]//p"
SCVCityBlank                = "//div[contains(@class,'MuiDialogContent-root')]//div[@class='column']//p"
SCVButtonAddressList        = "//button[contains(@class,'MuiAutocomplete-popupIndicator')]"

#home delivery
SCVHomeDeliveryButton                   = "//div[@id='checkout-delivery-pickupInStore']"

#checkout
FirstOtpVerificationMethod  = "//div[@role='dialog']//ul//div[@role='button']"
InputOTPLogin               = "//input[@id='checkout-loginOtp-textField']"
FirstOtpVerificationMethod  = "//div[@role='dialog']//ul//div[@role='button']"

# checkoutpage
SCVPayButton                            = "//button[@id='checkout-payButton']"
ValidateEmailAddressIsEmty              = "//input[@id='checkout-email-textField'][@value='']"
InputEmailCheckoutPage                  = "//input[@id='checkout-email-textField']"
CheckoutPageCountdown                   = "//div[contains(@class,'checkout')]//div[contains(@class,'countdown')]"
ButtonAddAddressCheckoutPage            = "//div[@id='checkoutShippingAddressHome']//button//img[contains(@class,'checkout-shipping-pin-img')]"
ButtonChangeSelectedAddressCheckoutPage = "//span[contains(@class,'checkout-address-changeButton')]"
ButtonAddPromo                          = "//div[@id='checkoutFeePromotionsHome']//div[@class='iconAndLabel']"
ButtonChangeBillingAddress              = "//div[@id='checkoutShippingAddressHome']//div[@class='column'][2]//span[contains(@class,'checkout-address-changeButton')]"
LabelInsuranceBillingId                 = "//span[normalize-space()='Asuransi pengiriman']"
LabelInsuranceBillingEn                 = "//span[normalize-space()='Shipping insurance']"

# Address List Page
ItemInAddressList                       = "//div[contains(@class,'MuiDialogContent-root')]//div[contains(@class,'MuiPaper-root MuiCard-root')]//div[contains(@class,'jss')]"
FirstItemInAddresListIsChecked          = "//div[contains(@class,'MuiDialogContent-root')]//div[contains(@class,'MuiPaper-root MuiCard-root')]//div[contains(@class,'jss')][1]//input[@checked]"
RadioButtonSelectFirstAddressInList     = "//div[contains(@class,'MuiDialogContent-root')]//div[contains(@class,'MuiPaper-root MuiCard-root')]//div[contains(@class,'jss')][1]//input"
RadioButtonSelectSecondAddressInList    = "//div[contains(@class,'MuiDialogContent-root')]//div[contains(@class,'MuiPaper-root MuiCard-root')]//div[contains(@class,'jss')][2]//input"
ButtonAddNewAddressInAddressList        = "//button[@id='checkout-address-addButton']"
ButtonSaveSelectedAddress               = "//button[@id='checkout-addressList-saveButton']"
ButtonCloseAddressList                  = "//div[contains(@class,'row btn-close')]//button"
ButtonSelectShippingMethod              = "//button[@id='checkout-shippingMethod-selectButton']"
ButtonSelectPaymentMethod               = "//button[@id='checkout-paymentMethod-selectButton']"
LabelSelectPaymentMethod                = "//div[@id='checkoutPaymentMethodHome']"
ButtonCheckoutPlaceOrder                = "//button[@id='checkout-payButton']"
CheckboxBillingAddressSameAsShippingAddress = "//input[@id='checkout-billingAddress-sameAddressCheckBox']"
CheckboxShippingInsurance               = "//input[@id='checkout-shipping-method-insurance']"

# Select Shipping Method Page
DropdownShippingMethodItem              = "//div[contains(@class,'checkout-shippingMethod-dropDownItem')][@aria-disabled='false']"
CloseFormSelectShippingMethod           = "//div[@id='shipping-method-dialog-title']//button[contains(@class,'checkout-close-btn')]"

# Select Shipping Method Page
DropdownVAMidtransMethodItem            = "//img[contains(@alt,'Virtual Account (Via Midtranssnap)')]"
DropdownBRIVAMidtransMethodItem         = "//img[contains(@alt,'BRI Virtual Account (Via Midtranssnap)')]"
DropdownBNIVAMidtransMethodItem         = "//img[@alt='BNI Virtual Account (Via Midtranssnap)']"
DropdownPermataVAMidtransMethodItem     = "//img[contains(@alt,'Permata Virtual Account (Via Midtranssnap)')]"


#Upsert Address Form
ButtonSaveAddressInAddressForm          = "//button[@id='checkout-address-saveButton']"
InputaddressRecipient                   = "//input[@id='checkout-addressRecipient-textField']"
DropdownAddressLabel                    = "//div[@id='address_label']"
DropdownAddressLabelList                = "//ul[@role='listbox']"
DropdownAddressLabelListLastItem        = "//ul[@role='listbox']//li[last()]"
InputAddressLabel                       = "//input[@id='checkout-addressLabelOther-textField']"
InputAddressPhoneNumber                 = "//input[@id='checkout-phonenumber-textField']"
InputAddressDetail                      = "//input[@id='checkout-addressDetail-textField']"
InputAddressCity                        = "//input[@id='checkout-addressCity-autoCompleteField']"
ListAddressCityFirstItem                = "//li[@id='checkout-addressCity-autoCompleteField-option-0']"
InputAddressPostalCode                  = "//input[@id='checkout-addressPostalCode-textField']"
ButtonToPinpoinLocationForm             = "//button[@id='checkout-addressPinPoint-button']"
InputGoogleMapSearchPinPointLocation    = "//input[@id='googleMaps-search-textField']"
ButtonSavePinPointLocation              = "//button[@id='checkout-addressPinPoint-saveButton']"

# Promotion
AddAvailPromo                          = "//div[contains(@class,'boxPromo')]"
InputPromoCode                         = "//input[@id='coupon']"
ButtonPasang                           = "//div[contains(@class,'MuiDialogContent')]//button"
AllertMessage                          = "//div[@class='MuiAlert-icon']"
ButtonClosePromo                       = "//img[@alt='Close Modal']"

# Mitrans
MidtransFrame                           = 'snap-midtrans'
MidtransPopup                           = 'id:application'
CloseMitransPopup                       = "//div[@class='close-snap-button clickable']"

# Thankyoupage
ThankyouPageHeader                      = "//div[contains(@class,'success-header success-section')]"
ButtonContinueShopping                  = "//button[@id='checkout-success-continueButton']"

# Allert
CheckoutSuccessAllert                   = "//div[contains(@class,'toast-message')]//div[contains(@class,'MuiAlert-standardSuccess')]"
InvalidSCVOTPAlert                      = "//div[@role='alert']"

# Promo Page
InputPromoCode                          = "//input[@id='coupon']"
ButtonApplyPromo                        = "//div[@aria-labelledby='promotion-dialog-title']//div[contains(@class,'MuiDialogContent-root')]//button"
ButtonApplyExistingPromo                = "//button[@id='checkout-promo-applyPromoButton']//span[@class='MuiButton-label']"
CheckedPromo                            = "//div[@aria-labelledby='promotion-dialog-title']//span[contains(@class,'Mui-checked')]"
ButtonRemovePromo                       = "//button[@id='checkout-promo-applyPromoButton']"
CheckBoxFirstExistingPromo              = "//li[1]//span[@class='MuiIconButton-label']"
CheckBoxSecondExistingPromo             = "//li[2]//span[@class='MuiIconButton-label']"

#giftcard
GiftCardInput                           = "//input[@id='checkout-giftcard-textField']"
GiftCardPasangButton                    = "//div[contains(@class,'giftcart-box')]//div[contains(@class,'MuiInputAdornment-positionEnd')]//span[contains(@class,'MuiTypography-root')]"
GiftCardLoader                          = "//div[contains(@class,'MuiCircularProgress-root')]"

#summary
GrandTotalInSummary                     = "//div[@id='checkoutOrderSummary']//div[contains(@class,'summary-total')]//span[2]"

#Pickup In Store
PISRecipientNameField                   = "//input[@id='checkout-pickUpPerson-textField']"
PISRecipientPhoneField                  = "//input[@id='checkout-pickUpPhoneNumber-textField']"
PISRecipientEmailField                  = "//input[@id='checkout-pickUpEmail-textField']"
PISButtonSaveRecipient                  = "//button[@id='checkout-pickUpInfo-saveButton']"
PISErrorMessageAlert                    = "//div[contains(@class,'Mui-error')]"
ButtonPickupInStore                     = "//div[@id='checkout-delivery-pickupInStore']"
ButtonPISNewRecipient                   = "//button[@id='checkout-pickUpStore-changeInfoButton']"
ButtonUbahRecipient                     = "//span[contains(@class,'pickup-btn-text')]"