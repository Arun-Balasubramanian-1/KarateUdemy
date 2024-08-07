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

  Scenario: v2 -> Get 10 articles
    * def timeValidator = read('classpath:helpers/time-validator.js')
    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response == { "articles": "#array", "articlesCount": 91 }
    And match each response.articles ==
    """
        {
          "slug": "#string",
          "title": "#string",
          "description": "#string",
          "body": "#string",
          "tagList": "#array",
          "createdAt": '#? timeValidator(_)',
          "updatedAt": '#? timeValidator(_)',
          "favorited": "#boolean",
          "favoritesCount": "#number",
          "author": {
            "username": "#string",
            "bio": "##string",
            "image": "#string",
            "following": "#boolean",
          }
        }
    """
