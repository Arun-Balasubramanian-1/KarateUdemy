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

### To run a specific test:

```shell
mvn test "-Dkarate.options=--tags @debug"
```

Explanation: Tests with @debug tag will be executed

- Multiple tags can be given for a test.
- Use "~" operator to ignore particular tag and execute remaining tests
```shell
mvn test "-Dkarate.options=--tags ~@sanity"
```