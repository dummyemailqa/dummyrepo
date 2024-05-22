# General
AddToCartButton             = "//button[@id='product-addtocart-button']"
ProductReviewButton         = "//div[@class='review-modal-wrapper']//button"
ProductNameOnPDP            = "//h1[contains(@class,'page-title')]//span"

#PDP Action
AddToWishListButton         = "//button[@id='add-to-wishlist']"

#Quantity
ProductQuantity             = "//input[@name='qty']"
ProductQuantityValidation   ="input[Name='qty']"

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