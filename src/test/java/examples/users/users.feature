Feature: sample karate test script
  for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * url 'https://cat-fact.herokuapp.com'

  Scenario: Get Facts
    Given path 'facts'
    When method get
    Then status 200
