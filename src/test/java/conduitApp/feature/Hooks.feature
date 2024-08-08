@debug
Feature: Hooks

Background:
  * print "I am background"
  * def result = call read('classpath:helpers/sample.feature')
  * def name = result.username
  
Scenario: First Scenario
  * print name
  * print "I am first scenario"

Scenario: Second Scenario
  * print name
  * print "I am second scenario"
