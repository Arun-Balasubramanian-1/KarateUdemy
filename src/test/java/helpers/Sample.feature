Feature: Sample
 
Scenario: Generate Username
  * def dataGenerator = Java.type('helpers.DataGenerator')
  * def username = dataGenerator.getRandomUserName()
