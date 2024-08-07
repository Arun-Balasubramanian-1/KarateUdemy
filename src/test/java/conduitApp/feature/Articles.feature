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

Scenario: Like an Article
  Given path 'articles'
  And request articleRequestBody
  When method Post
  Then status 201
  And match response.article.title == articleRequestBody.article.title
  * def favoriteCount = response.article.favoritesCount
  * def articleSlug = response.article.slug

  Given path 'articles/' + articleSlug + '/favorite'
  And request {}
  When method Post
  Then status 200

  Given params { limit: 10, offset: 0}
  Given path 'articles'
  When method Get
  Then status 200
  And match response.articles[0].favoritesCount == (favoriteCount + 1)

Scenario: Comment an Article
  Given path 'articles'
  And request articleRequestBody
  When method Post
  Then status 201
  And match response.article.title == articleRequestBody.article.title
  * def articleSlug = response.article.slug

  Given path 'articles/' + articleSlug + '/comments'
  When method Get
  Then status 200
  And match response.comments == []
  * def commentsLength = karate.sizeOf(response.comments)

  Given path 'articles/' + articleSlug + '/comments'
  * def comment = "hello world"
  And request 
  """
    {
      "comment": {
        "body": #(comment)
      }
    }
  """
  When method Post
  Then status 200
  And match response.comment.body == comment
  
  Given path 'articles/' + articleSlug + '/comments'
  When method Get
  Then status 200
  And match karate.sizeOf(response.comments) == (commentsLength + 1)
  And match response.comments[0].body == comment

