@debug
Feature: Hooks

Background:
  * print "I am background"

  * configure afterFeature = function() { karate.call('classpath:helpers/sample.feature')}
  
Scenario: First Scenario
  * print "I am first scenario"

Scenario: Second Scenario
  * print "I am second scenario"
