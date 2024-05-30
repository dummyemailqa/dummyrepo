*** Settings ***
Documentation       Suite description
Resource            ../base/setup.robot
Resource            ../base/base.robot
Resource            ../pages/login_page.robot
Resource            ../pages/my_account_page.robot
Resource            ../pages/wishlist_page.robot

Test Setup          Start Test Case
Test Teardown       End Test Case

*** Test Cases ***
TCWL1-L.Logged In user is able to add comment to the product at wishlist page
    Login User
    To My Wishlist From Nav Bar
    Check Product on Wishlist
    Add Comment to Wishlist Product
    
TCWL2-L.Logged In user is able to delete product from wishlist page
    Login User
    To My Wishlist From Nav Bar
    Check Product on Wishlist
    Remove Wishlist Product

TCWL3-L.Logged In User is able to Add to Cart product from wishlist page (single product)
    Login User
    To My Wishlist From Nav Bar
    Check Product on Wishlist
    Add To Cart Product from Wishlist