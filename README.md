# KarateUdemy

## URLs

- **App URL:** [https://conduit.bondaracademy.com/](https://conduit.bondaracademy.com/)
- **API URL:** [https://conduit-api.bondaracademy.com/](https://conduit-api.bondaracademy.com/)

## Execution Commands

### To run all tests:

```shell
mvn test
```
- Use @ignore to ignore a particular test.

### To run specific tests:

```shell
mvn test "-Dkarate.options=--tags @debug"
```

Explanation: Tests with @debug tag will be executed

- Multiple tags can be given for a test. Test can have both debug and sanity tag. 
  On executing below command only the tests with sanity tag will be executed.
```shell
mvn test "-Dkarate.options=--tags @sanity"
```
- Use "~" operator to ignore particular tag and execute remaining tests
```shell
mvn test "-Dkarate.options=--tags ~@sanity"
```
- Execute particular test using classpath instead of tag. classpath starts from src/test/java .
```shell
mvn test "-Dkarate.options=classpath:conduitApp/feature/HomePage.feature:33"
``` 

### Debugging:
- First check StackTrace for file name, line number or error message.
- Then use (* print) to print values.
- Then comment the section and rerun few times to narrow down the issue.