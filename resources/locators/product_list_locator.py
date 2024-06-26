ProductItemCard             = "//main[@id='maincontent']//form[1]"
ProductsListViewIcon        = "//strong[@title='Grid']/preceding-sibling::button[@title='List']"
ProductListViewContainer    = "//div[contains(@class,'mode-list')]"
ProductsGridViewIcon        = "//strong[@title='List']/following-sibling::button[@title='Grid']"
ProductGridViewContainer    = "//div[contains(@class,'mode-grid')]"
PLPProductName              = "//form[contains(@class,'product-item')]//div[contains(@class,'product-info')]//a[contains(@class,'product-item-link')]"
CompareButtonFirstProduct   = "//form[contains(@class,'product-item')][1]//div[contains(@class,'product-info')]//button[contains(@class,'tocompare')]"
CompareButtonPDP            = "//button[@id='add-to-compare']"
TextSuggestedProduct        = "//div[@class='product-info-main']//span[@data-ui-id='page-title-wrapper']"
ProductNameTitle            = "//a[@class='product-item-link']"
VarianConfigurableInPLP     = "//div[contains(@x-data,'initConfigurableSwatchOptions_1268')]"

#Button
AddToCartButton             = "//button[@id='product-addtocart-button']"

# Sorting
SortAsc  = "ASC"
productItemPrice    =   "//section[@id='product-list']//form[{}]//div[contains(@class,'product-info')]//span[@class='price']"

# Product Card Detail
ProductItemCardName         = "//form[contains(@class,'product-item')][{}]//a[@class='product-item-link']"
ProductItemAddToCartButton  = "xpath=(//button[contains(@class,'btn-primary') and contains(@aria-label,'Add to Cart')])"

#Allert
SuccessAddToCartAllert = "//div[@ui-id='message-success']"