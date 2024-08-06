Feature: Signup

  Background:
    * def dataGenerator = Java.type('helpers.DataGenerator')
    Given url apiUrl
    * def date = new java.util.Date()
    * def sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss")
    * def timestamp = sdf.format(date)

  @debug
  Scenario: New user signup
    * def username = dataGenerator.getRandomUserName()
    * def email = username + '@conduit.com'
    Given path 'users'
    And request
    """
      {
        "user": {
          "email": #(email),
          "password": "test",
          "username": #(username)
        }
      }
    """
    When method Post
    Then status 201
