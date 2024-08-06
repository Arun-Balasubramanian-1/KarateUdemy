@debug
Feature: Signup

  Background:
    Given url apiUrl
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomUserName = dataGenerator.getRandomUserName()
    * def randomEmail = randomUserName + '@conduit.com'

  Scenario: New user signup
    Given path 'users'
    And request
    """
      {
        "user": {
          "email": #(randomEmail),
          "password": "test",
          "username": #(randomUserName)
        }
      }
    """
    When method Post
    Then status 201


  Scenario Outline: New user signup 4xx validations
    Given path 'users'
    And request
    """
      {
        "user": {
          "email": <email>,
          "password": "test",
          "username": <name>,
        }
      }
    """
    When method Post
    Then status <responseCode>
    Then match response == <errorResponse>

    Examples:
      | email             | name                      | responseCode | errorResponse                                      |
      | arun@conduit.com  | #(randomUserName)         | 422          | {"errors":{"email":["has already been taken"]}}    |
      |                   | #(randomUserName)         | 422          | {"errors":{"email":["can't be blank"]}}            |
      | null              | #(randomUserName)         | 422          | {"errors":{"email":["can't be blank"]}}            |
      | #(randomEmail)    | arun                      | 422          | {"errors":{"username":["has already been taken"]}} |
      | #(randomEmail)    |                           | 422          | {"errors":{"username":["can't be blank"]}}         |
      | #(randomEmail)    | null                      | 422          | {"errors":{"username":["can't be blank"]}}         |