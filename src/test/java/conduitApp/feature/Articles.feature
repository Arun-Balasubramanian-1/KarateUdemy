@debug
Feature: Create and Delete Articles

Background:
  Given url apiUrl
  * def articleRequestBody = read('classpath:json/createArticle.json')
  * def dataGenerator = Java.type('helpers.DataGenerator')
  * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
  * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
  * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

Scenario: Create Article
  Given path 'articles'
  And request articleRequestBody
  When method Post
  Then status 201
  And match response.article.title == articleRequestBody.article.title

@run
Scenario: Create and delete article
  Given path 'articles'
  And request articleRequestBody
  When method Post
  Then status 201
  And match response.article.title == articleRequestBody.article.title
  * def articleId = response.article.slug

  Given params { limit: 10, offset: 0}
  Given path 'articles'
  When method Get
  Then status 200
  And match response.articles[0].title == articleRequestBody.article.title

  Given path 'articles/' + articleId
  When method Delete
  Then status 204

  Given params { limit: 10, offset: 0}
  Given path 'articles'
  When method Get
  Then status 200
  And match response.articles[0].title != articleRequestBody.article.title

