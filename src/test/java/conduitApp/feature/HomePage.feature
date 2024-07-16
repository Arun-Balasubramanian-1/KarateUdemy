Feature: Home Page Tests

  Background: Define the url
    Given url 'https://conduit-api.bondaracademy.com/api/'
  Scenario: Get all Tags
    Given path 'tags'
    When method Get
    Then status 200

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