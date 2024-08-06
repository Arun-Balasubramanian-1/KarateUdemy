package helpers;

import com.github.javafaker.Faker;

public class DataGenerator {

  public static String getRandomUserName() {
    Faker faker = new Faker();
    return faker.name().username();
  }
}