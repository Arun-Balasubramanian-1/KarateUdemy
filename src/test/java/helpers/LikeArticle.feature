Feature: Article

Background:
  Given url apiUrl
 
Scenario: Like Article
  Given path 'articles/' + slug + '/favorite'
  And request {}
  When method Post
  Then status 200
  * def LikesCount = response.article.favoritesCount
  