@debug
Feature: Create and Delete Articles

Background:
  Given url apiUrl
  * def response = callonce read('classpath:helpers/CreateToken.feature')
  * def token = response.authToken
  * def uuid = function(){ return java.util.UUID.randomUUID() + '' }
  * def articleTitle = 'Article ' + uuid()

Scenario: Create Article
  Given path 'articles'
  And request { "article": {"title": '#(articleTitle)', "description": "conduit", "body": "hello", "tagList": ["one"]}}
  When method Post
  Then status 201
  And match response.article.title == articleTitle

@run
Scenario: Create and delete article
  Given path 'articles'
  And request { "article": {"title": '#(articleTitle)', "description": "conduit", "body": "hello", "tagList": ["one"]}}
  When method Post
  Then status 201
  And match response.article.title == articleTitle
  * def articleId = response.article.slug

  Given params { limit: 10, offset: 0}
  Given path 'articles'
  When method Get
  Then status 200
  And match response.articles[0].title == articleTitle

  Given path 'articles/' + articleId
  When method Delete
  Then status 204

  Given params { limit: 10, offset: 0}
  Given path 'articles'
  When method Get
  Then status 200
  And match response.articles[0].title != articleTitle

