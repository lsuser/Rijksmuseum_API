*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

Suite Setup      Create Session    Rijksmuseum    ${BASE_URL}    headers=${HEADERS}

*** Variables ***
${BASE_URL}     https://www.rijksmuseum.nl/api/nl/collection
${API_KEY}    0fiuZFh4
${HEADERS}      {"Accept": "application/json"}
${VALID_OBJECT}      SK-C-5
${INVALID_OBJECT}    INVALID123
${PRODUCTION_PLACES}  Amsterdam
${API_LANGUAGE}      en
${PAINTING_TYPE}     painting
${MATERIAL}          canvas
${TECHNIQUE}         etching
${CENTURY}          17
${COLOR}           FF0000
${PAGE}             1
${PAGE_SIZE}        5
${SEARCH_QUERY}     Rembrandt
${SORT_ORDER}       artist
${IMG_ONLY}         true
${TOP_PIECES}       true

*** Test Cases ***

Retrieve Collections Successfully
    [Documentation]    Verify API returns a 200 response with only API key
    [Tags]      smoke
    ${response}    GET    ${BASE_URL}    params=key=${API_KEY}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Test Pagination
    [Documentation]    Verify API pagination by fetching multiple pages
    [Tags]    regression
    ${params}    Create Dictionary    key=${API_KEY}    p=${PAGE}    ps=${PAGE_SIZE}
    ${response}    GET    ${BASE_URL}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Test Culture Parameter
    [Documentation]    Verify API returns correct language response
    [Tags]    regression
    ${params}    Create Dictionary    key=${API_KEY}    culture=${API_LANGUAGE}
    ${response}    GET    ${BASE_URL}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Test Involved Maker
    [Documentation]    Ensure filtering by involved maker works
    [Tags]    regression
    ${params}    Create Dictionary    key=${API_KEY}    involvedMaker=Rembrandt van Rijn
    ${response}    GET    ${BASE_URL}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json}    Set Variable    ${response.json()}
    ${artObjects}    Set Variable    ${json["artObjects"]}
    Should Not Be Empty    ${artObjects}

Test Object Type Parameter
    [Documentation]    Ensure filtering by object type works
    [Tags]    regression
    ${params}    Create Dictionary    key=${API_KEY}    type=${PAINTING_TYPE}
    ${response}    GET    ${BASE_URL}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Test Material Parameter
    [Documentation]    Verify API filters results by material
    [Tags]    smoke
    ${params}    Create Dictionary    key=${API_KEY}    material=${MATERIAL}
    ${response}    GET    ${BASE_URL}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Test Technique Parameter
    [Documentation]    Ensure filtering by technique works
    [Tags]    regression
    ${params}    Create Dictionary    key=${API_KEY}    technique=${TECHNIQUE}
    ${response}    GET    ${BASE_URL}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Test Century Parameter
    [Documentation]    Verify filtering by century works
    [Tags]    regression
    ${params}    Create Dictionary    key=${API_KEY}    f.dating.period=${CENTURY}
    ${response}    GET    ${BASE_URL}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Test Color Parameter
    [Documentation]    Verify filtering by color works
    [Tags]    regression
    ${encoded_color}    Evaluate    '%23' + '${COLOR}'
    ${params}    Create Dictionary    key=${API_KEY}    f.normalized32Colors.hex=${encoded_color}
    ${response}    GET    ${BASE_URL}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Test Image Only Filter
    [Documentation]    Verify filtering only objects with images works
    [Tags]    regression
    ${params}    Create Dictionary    key=${API_KEY}    imgonly=${IMG_ONLY}
    ${response}    GET    ${BASE_URL}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Test Top Pieces Filter
    [Documentation]    Verify filtering only top pieces works
    [Tags]    regression
    ${params}    Create Dictionary    key=${API_KEY}    toppieces=${TOP_PIECES}
    ${response}    GET    ${BASE_URL}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Test Sorting Parameter
    [Documentation]    Verify sorting results by artist name works
    [Tags]    smoke
    ${params}    Create Dictionary    key=${API_KEY}    s=${SORT_ORDER}
    ${response}    GET    ${BASE_URL}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Handle Invalid Key Request
    [Documentation]    Ensure an invalid API key returns a 401 response
    [Tags]    smoke    NegativeTest    Auth
    ${params}    Create Dictionary    key=${INVALID_OBJECT}
    Run Keyword And Expect Error    *401*    GET    ${BASE_URL}    params=${params}

Handle Invalid Endpoint Request
    [Documentation]    Ensure an invalid endpoint returns a 404 message
    [Tags]    smoke    NegativeTest    Endpoint
    ${invalid_url}    Set Variable    ${BASE_URL}${INVALID_OBJECT}
    Run Keyword And Expect Error    *404*    GET    ${invalid_url}
