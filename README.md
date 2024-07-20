# KarateUdemy

## URLs

- **App URL:** [https://conduit.bondaracademy.com/](https://conduit.bondaracademy.com/)
- **API URL:** [https://conduit-api.bondaracademy.com/](https://conduit-api.bondaracademy.com/)

## Execution Commands

### To run all tests:

```shell
mvn test
```
### To run a specific test:

```shell
mvn test "-Dtest=ConduitTest#testTags"
```

Explanation: mvn test "-Dtest={TestRunner ClassName}#{TestRunner MethodName}"
It will run the tests with the tags mentioned in the testTags method.