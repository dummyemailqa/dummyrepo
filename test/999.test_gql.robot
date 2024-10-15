*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${API_URL}        http://swift-hyva.testingnow.me/graphql
${EMAIL}          dummyemailqa@gmail.com    
${PASSWORD}       PasswordStrength123         
${response_code} 

*** Test Cases ***
Generate Customer Token And Verify Response
    # Step 1: Define GraphQL Query
    ${query}=         Set Variable    mutation { generateCustomerToken(email: "${EMAIL}", password: "${PASSWORD}") { token } }

    # Step 2: Send POST Request to API
    Create Session    graphql    ${API_URL}
    ${headers}=       Create Dictionary    Content-Type=application/json

    ${payload}=       Create Dictionary    query=${query}
    ${response}=      POST on Session    graphql    /    json=${payload}    headers=${headers}

    # Step 3: Extract and Verify Status Code manually
    ${response_code}=    Set Variable    ${response.status_code}
    Log    Response Code: ${response_code}
    Should Be Equal As Numbers    ${response_code}    200

    # Step 4: Extract the JSON response body directly
    ${response_body}=    Set Variable    ${response.json()}
    Log    Full Response Body: ${response_body}

    # Step 5: Retrieve 'data' dictionary
    ${data}=    Get From Dictionary    ${response_body}    data

    # Step 6: Retrieve 'generateCustomerToken' dictionary from 'data'
    ${generateCustomerToken}=    Get From Dictionary    ${data}    generateCustomerToken

    # Step 7: Retrieve 'token' from 'generateCustomerToken'
    ${token}=    Get From Dictionary    ${generateCustomerToken}    token

    # Step 8: Verify the token is present
    Should Not Be Empty    ${token}
    Log    Token generated: ${token}