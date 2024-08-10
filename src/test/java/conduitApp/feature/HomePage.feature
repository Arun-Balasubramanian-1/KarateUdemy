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
    And match response == { "articles": "#array", "articlesCount": "#number" }
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

  Scenario: Like Article if already not liked
    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount
    * def article = response.articles[0]

    * def result = (favoritesCount == 0) ? karate.call('classpath:helpers/likeArticle.feature', article).LikesCount : favoritesCount

    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].favoritesCount == result

  @debug
  Scenario: retry until
    * configure retry = { count: 10, interval: 2000 }
    Given params { limit: 10, offset: 0}
    Given path 'articles'
    And retry until response.articles[0].favoritesCount == 1
    When method Get
    Then status 200