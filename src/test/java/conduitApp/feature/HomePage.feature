Feature: Home Page Tests

  Background: Define the url
    Given url apiUrl

  @sanity
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
    # Contains atleast one of the items in the list
    And match response.tags contains any ["Teams", "Zoom", "Youtube"]

  Scenario: Get Articles
    Given path 'articles'
    When method Get
    Then status 200

  @ignore
  Scenario: v1 -> Get 10 articles
    Given param limit = 10
    Given param offset = 0
    Given path 'articles'
    When method Get
    Then status 200

  @debug
  Scenario: v2 -> Get 10 articles
    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    # Validating the count of items in list response
    And match response.articles == "#[10]"

    And match response.articlesCount == 78
    And match response.articlesCount != 79
    # Both Datatype and Value validation
    And match response == { "articles": "#array", "articlesCount": 78 }
    # partial value validation in a nested key
    And match response.articles[0].createdAt contains "2024"
    # [*] for all elements in the articles array
    And match response.articles[*].favoritesCount contains 1
    # Shorthand for nested keys validation
    And match response..username contains "arun"
    # Match all elements
    And match each response..following == false
