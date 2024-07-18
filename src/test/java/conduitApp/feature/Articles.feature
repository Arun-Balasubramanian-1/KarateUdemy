Feature: Create Articles

Background:
  Given url 'https://conduit-api.bondaracademy.com/api/'
Scenario:
  Given path 'users/login'
  And request {"user": {"email": "arun@conduit.com", "password": "arunconduit"}}
  When method Post
  Then status 200
  * def token = response.user.token

  Given path 'articles'
  And header Authorization = 'Token ' + token
  * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
  * def articleTitle = 'Article ' + uuid()
  And request { "article": {"title": '#(articleTitle)', "description": "conduit", "body": "hello", "tagList": ["one"]}}
  When method Post
  Then status 201
  And match response.article.title == articleTitle