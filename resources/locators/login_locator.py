FromLogin       = "//form[@id='customer-login-form']"
LoginUsername   = "//input[@id='email']"
LoginPassword   = "//input[@id='pass']"
ButtonLogin     = "//button[@name='send']"

# Login By Phone Number
ButtonSwitchLoginByPhoneNumber  = "//div[@class='flex justify-center']//label[2]"
LoginPhoneNumber                = "//div[contains(@class,'login-sms')]//input[@name='phone']"
ButtonRequestOTP                = "//button[@id='requestOTP']"

#ErrorMessages
AlertInvalidEmailFormat    = "//li[@data-msg-field='login[username]']"
AllertLoginSMSMessageError = "//form[@id='login-sms-form']//span[@x-html='errorMessage']"
AllertMessageError         = "//div[@ui-id='message-error']"