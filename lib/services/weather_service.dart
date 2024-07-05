import 'dart:convert';
import '../models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = 'af9f93ff0061995f4964fd04fbbec6c7';
  static const String apiUrl = 'http://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$apiUrl?q=$cityName&units=metric&appid=$apiKey'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
