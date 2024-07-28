Feature: Token

Scenario: Create Token
  Given url 'https://conduit-api.bondaracademy.com/api/'
  Given path 'users/login'
  And request {"user": {"email": "arun@conduit.com", "password": "arunconduit"}}
  When method Post
  Then status 200
  * def authToken = response.user.token