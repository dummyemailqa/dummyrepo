# Header
HeaderLinkToLogin   = "//div[contains(@class,'header-icons-wrapper')]//button[@id='customer-menu']"
ButtonSignIn        = "//a[@id='customer.header.sign.in.link']"
CustomerMenuSignOut = "//a[@id='customer.header.sign.out.link']"
CustomerMenuWishlist= "//a[@id='customer.header.wishlist.link']"
UserLoggedInIcon    = "//div[contains(@class,'header-icons-wrapper')]//button[@id='customer-menu']//span[contains(@x-text,'customer.firstname')]"
CustomerMenuFirstItem   = '//nav[@aria-labelledby="customer-menu"]/a[1]'
MenuWoman           = "//a[@title='Women']"
ToggleCurrency      = "//div[@x-data='initCurrency()']//button"
CurrencyItem        = "//div[@x-data='initCurrency()']//div[@role='menu']//a[1]"
BannerCarousel      = "//a[@class='mgz-carousel-custom_link']"
CategoryMenuByIndex = "//nav[@aria-label='Main menu']//ul[@class='flex flex-wrap']//li[{}]//a[contains(@class,'items-center')]"
#Search
SearchBox           = "//input[@id='search']"
SuggestedProduct    = "//a[@class='w-full block p-2']//span[@x-text='searchResult.title']"
SuggestionCategorySearch    = "//div[@id='search_autocomplete']//div[@ha='hyva-search-list'][3]//span[@x-text='searchResult.title']"

#Content
ProductPriceInHomePage  = "//form[contains(@class,'item product product-item')]//span[@class='price']"