Feature: Create and Delete Articles


Background:
  Given url 'https://conduit-api.bondaracademy.com/api/'
  Given path 'users/login'
  And request {"user": {"email": "arun@conduit.com", "password": "arunconduit"}}
  When method Post
  Then status 200
  * def token = response.user.token
  * def uuid = function(){ return java.util.UUID.randomUUID() + '' }

Scenario: Create Article
  Given path 'articles'
  And header Authorization = 'Token ' + token
  * def articleTitle = 'Article ' + uuid()
  And request { "article": {"title": '#(articleTitle)', "description": "conduit", "body": "hello", "tagList": ["one"]}}
  When method Post
  Then status 201
  And match response.article.title == articleTitle

@run
Scenario: Create and delete article
  Given path 'articles'
  And header Authorization = 'Token ' + token
  * def articleTitle = 'Article ' + uuid()
  And request { "article": {"title": '#(articleTitle)', "description": "conduit", "body": "hello", "tagList": ["one"]}}
  When method Post
  Then status 201
  And match response.article.title == articleTitle
  * def articleId = response.article.slug

  Given params { limit: 10, offset: 0}
  Given path 'articles'
  And header Authorization = 'Token ' + token
  When method Get
  Then status 200
  And match response.articles[0].title == articleTitle

  Given path 'articles/' + articleId
  And header Authorization = 'Token ' + token
  When method Delete
  Then status 204

  Given params { limit: 10, offset: 0}
  Given path 'articles'
  And header Authorization = 'Token ' + token
  When method Get
  Then status 200
  And match response.articles[0].title != articleTitle

