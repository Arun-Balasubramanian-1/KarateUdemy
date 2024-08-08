Feature: Token

Scenario: Create Token
  Given url apiUrl
  Given path 'users/login'
  And request {"user": {"email": "#(userEmail)", "password": "#(userPassword)"}}
  When method Post
  Then status 200
  * print "Checking karate.callSingle"
  * def authToken = response.user.token