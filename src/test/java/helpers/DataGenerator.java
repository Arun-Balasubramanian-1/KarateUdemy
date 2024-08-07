package helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator {

  public static String getRandomUserName() {
    Faker faker = new Faker();
    return faker.name().username();
  }

  public static JSONObject getRandomArticleValues() {
    JSONObject json = new JSONObject();
    Faker faker = new Faker();
    json.put("title", faker.name().title());
    json.put("description", faker.address().fullAddress());
    json.put("body", faker.address().cityName());
    return json;
  }
}