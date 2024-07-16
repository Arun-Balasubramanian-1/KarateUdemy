Feature: Home Page Tests

  Scenario: Get all Tags
    Given url 'https://conduit-api.bondaracademy.com/api/tags'
    When method Get
    Then status 200

  Scenario: v1 -> Get 10 articles
    Given url 'https://conduit-api.bondaracademy.com/api/articles?limit=10&offset=0'
    When method Get
    Then status 200

  Scenario: v2 -> Get 10 articles
    Given param limit = 10
    Given param offset = 0
    Given url 'https://conduit-api.bondaracademy.com/api/articles'
    When method Get
    Then status 200

  Scenario: v3 -> Get 10 articles
    Given params { limit: 10, offset: 0}
    Given url 'https://conduit-api.bondaracademy.com/api/articles'
    When method Get
    Then status 200