#General
AddToCartButton                         = "//button[@id='product-addtocart-button']"
AddToCartButtonBundle                   = "//button[@type='submit' and @id='product-addtocart-button']"
ProductReviewButton                     = "//div[@class='review-modal-wrapper']//button"
QTYInput                                = "//div[contains(@class,'product-info-main')]//input[contains(@name,'qty')]" 
PDPProductName                          = "//div[contains(@class,'product-info-main')]//div[contains(@class,'container')]//h1[contains(@class,'page-title')]//span[contains(@data-ui-id,'page-title-wrapper')]"
ProductNameOnPDP                        = "//h1[contains(@class,'page-title')]//span"

# Manage Configurable Product
ProductConfigurable                     = "//body[contains(@class,'page-product-configurable')]"
TotalProductConfigurable                = "//form[contains(@id,'product_addtocart_form')]//div[contains(@class,'swatch-attribute ')]"
ProductConfigurableOptionItem           = "//form[contains(@id,'product_addtocart_form')]//div[contains(@class,'swatch-attribute ')][{}]//label[contains(@class,'swatch-option')]"

# Manage Bundle Product
ProductBundle                           = "//body[contains(@class,'page-product-bundle')]"
BtnCutomizeProductBundle                = "//div[contains(@class,'bundle-product')]//button[@id='product-addtocart-button']"
ProductBundleOption                     = "//fieldset[contains(@class,'fieldset-bundle-options')]//div[@ha='bundle-item-list']"
ProductBundleOptionSelect               = "//fieldset[contains(@class,'fieldset-bundle-options')]//div[@ha='bundle-item-list'][{}]//select[@multiple='multiple']"
BtnProductBundleOptionSelect            = "//fieldset[contains(@class,'fieldset-bundle-options')]//div[@ha='bundle-item-list'][{}]//select[@multiple='multiple']//option[last()]"
ProductBundleOptionRadioContainer       = "//fieldset[contains(@class,'fieldset-bundle-options')]//div[@ha='bundle-item-list'][{}]//div[@role='radiogroup']"
BtnRadioProductBundleOptionRadio        = "//fieldset[contains(@class,'fieldset-bundle-options')]//div[@ha='bundle-item-list']//div[@role='radiogroup']//input[(contains(@class, 'radio product bundle option')and not(@disabled))]"
QTYInputRadioBundle                     = "//fieldset[contains(@class,'fieldset-bundle-options')]//div[@ha='bundle-item-list']//div[contains(@ha,'qty-radio')]//button[last()]" 
ProductBundleOptionCheckboxContainer    = "//fieldset[contains(@class,'fieldset-bundle-options')]//div[@ha='bundle-item-list'][{}]//input[@type='checkbox']"
ProductBundleOptionSelectDropdown       = "//fieldset[contains(@class,'fieldset-bundle-options')]//div[@ha='bundle-item-list'][{}]//select[@ha='bundleSelect']"
BtnProductBundleOptionSelectDropdown    = "//fieldset[contains(@class,'fieldset-bundle-options')]//div[@ha='bundle-item-list'][{}]//option[not(@disabled)][last()]"
QTYInputSelectBundle                    = "//fieldset[contains(@class,'fieldset-bundle-options')]//div[@ha='bundle-item-list']//div[contains(@ha,'qty-select')]//button[last()]" 

# Manage Group Product
ProductGroup                            = "//body[contains(@class,'page-product-group')]"
ProductGroupOption                      = "//div[@x-data='initGroupedOptions()']//div[@ha='group-item-list']"
ProductGroupItem                        = "//div[@x-data='initGroupedOptions()']//div[@ha='group-item-list'][{}]//input"
GroupProductName                        = "//div[@x-data='initGroupedOptions()']//div[@ha='group-item-list'][{}]//span[contains(@class,'product-item-name')]"

#PDP Action
AddToWishListButton         = "//button[@id='add-to-wishlist']"

#Quantity
ProductQuantity             = "//input[@name='qty']"
ProductQuantityValidation   = "input[Name='qty']"

#Product Review
ReviewRatingButton          = "//form[@id='review_form']//input[contains(@id,'Rating_{}')]"
ReviewRatingInputValidation = "input[name='ratings[4]']"
ReviewNameInput             = "//form[@id='review_form']//input[@id='nickname_field']"
ReviewNameInputValidation   = "input[id='nickname_field']"
ReviewTitleInput            = "//form[@id='review_form']//input[@id='summary_field']"
ReviewTitleInputValidation  = "input[name='title']"
ReviewDetailInput           = "//form[@id='review_form']//textarea[@id='review_field']"
ReviewDetailInputValidation = "textarea[name='detail']"
ReviewSubmitButton          = "//form[@id='review_form']//button[2]"
ReviewCancelSubmitButton    = "//form[@id='review_form']//div[2]//button[1]"
ReviewAlertSuccess         = "//p[@x-show='displaySuccessMessage']"