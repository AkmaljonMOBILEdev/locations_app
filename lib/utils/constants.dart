const baseUrl = "https://geocode-maps.yandex.ru";
const String apiKey = "c652e55f-1581-4bbc-b1e9-99cc4d3ee4b5";

class TimeOutConstants {
  static int connectTimeout = 30;
  static int receiveTimeout = 25;
  static int sendTimeout = 60;
}

const List<String> mapTypes = [
  "Default",
  "Satellite",
  "Terrain"
];

const List<String> kindList = [
  "house",
  "metro",
  "district",
  "street",
];

const List<String> langList = [
  "UZ",
  "RU",
  "EN",
  "TR",
];

