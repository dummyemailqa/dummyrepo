*** Settings ***
Documentation   Suite description
Resource    ../base/setup.robot
Resource    ../base/base.robot
Resource    ../pages/home_page.robot
Resource    ../pages/product_detail_page.robot
Resource    ../pages/Product_list_page.robot
Variables   ../resources/locators/product_list_locator.py
Variables   ../resources/data/testdata.py

Test Setup  Start Test Case
# Test Teardown    End Test Case

*** Test Cases ***
TCPDP5.Validation Maximum Quantity Validation During Adding Product to Cart
    [Tags]    PDP
    Search Product by Keyword in Searchbox  ${ProductSimpleNameForSearch}
    Wait Until Element Is Visible With Long Time    ${ProductItemCard}
    Element Should Be Visible   ${ProductItemCard}
    Go To PDP Product By Index    2
    Input Item Qty    QTY=100001
    Add To Cart
    # Perlu menambahkan validasi error




    