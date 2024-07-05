import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String? _error;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;

  WeatherProvider() {
    _loadLastCity();
  }

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _weather = await WeatherService().fetchWeather(cityName);
      _saveLastCity(cityName);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveLastCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('last_city', cityName);
  }

  Future<void> _loadLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    final cityName = prefs.getString('last_city');
    if (cityName != null) {
      await fetchWeather(cityName);
    }
  }

  Future<void> loadLastCityWeather() async {
    await _loadLastCity();
  }

  void clearWeather() {
    _weather = null;
    notifyListeners();
  }
}
