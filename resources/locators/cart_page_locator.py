MinicartDeleteItem      = "//button[contains(@aria-label, 'Remove product')]"
BtnCloseMiniCart        = "//button[contains(@aria-label, 'Close minicart')]"
MinicartProductItem     = "//div[contains(@aria-label, 'My Cart')]//div[contains(@class,'flex items-start')]"
MinicartProductName     = "//div[contains(@aria-label, 'My Cart')]//div[contains(@class,'items-start')][{}]//p[@x-html='item.product_name']"

#Shopping Cart
ButtonViewCart          = "//a[contains(@href,'/checkout/cart/')]"
ButtonToCheckout        = "//a[@id='checkout-link-button']"
MinicartQty             = "//span[@x-text='qty']"

MinicartIncrease        = "//div[contains(@class,'items-start')]//div[contains(@class,'gap-2')]//button[2]"
MinicartDecrease        = "//div[contains(@class,'items-start')]//div[contains(@class,'gap-2')]//button[1]"
MinicartLoader          = "//div[@x-show='isLoading']"
MinicartSubtotal        = "//span[@x-html='cart.subtotal']"

#Shopping Cart
ButtonViewCart          = "//a[contains(@href,'/checkout/cart/')]"
ButtonToCheckout        = "//a[@id='checkout-link-button']"
ButtonIncrease          = "//button[@class='btn-increase']"
ButtonDecrease          = "//button[@class='btn-decrease']"
ShoppingCartLoader      = "//div[@class='loader']"
ShoppingCartTotalPrice  = "//div[@x-text='hyva.formatPrice(segment.value)']"
ShoppingCartDelete      = "//tr[contains(@class,'item-actions')]//button[contains(@class,'action-delete')]"
ButtonStartShopping     = "//div[contains(@class,'cart-empty')]//a"