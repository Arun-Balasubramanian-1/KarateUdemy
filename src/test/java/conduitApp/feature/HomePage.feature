Feature: Home Page Tests

  Background: Define the url
    Given url 'https://conduit-api.bondaracademy.com/api/'
  Scenario: Get all Tags
    Given path 'tags'
    When method Get
    Then status 200
    # Validating the Datatype in response
    And match response.tags == "#array"
    And match each response.tags == "#string"
    # Validating partial data in response 
    And match response.tags contains "GitHub"
    And match response.tags !contains "GitLab"
    And match response.tags contains ["Zoom", "YouTube"]
    And match response.tags !contains ["Zoom", "Youtube"]

  Scenario: Get Articles
    Given path 'articles'
    When method Get
    Then status 200

  Scenario: v1 -> Get 10 articles
    Given param limit = 10
    Given param offset = 0
    Given path 'articles'
    When method Get
    Then status 200

  Scenario: v2 -> Get 10 articles
    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    # Validating the count of items in list response
    And match response.articles == "#[10]"
    # Validating the response data
    And match response.articlesCount == 10