@debug
Feature: Hooks

Background:
  * print "I am background"

  * configure afterScenario = function() { karate.call('classpath:helpers/sample.feature')}
  * configure afterFeature = 
  """
    function() {
      karate.log('After Feature Execution.....')
    }
  """
  
Scenario: First Scenario
  * print "I am first scenario"

Scenario: Second Scenario
  * print "I am second scenario"
