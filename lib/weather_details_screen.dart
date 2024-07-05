import 'package:flutter/material.dart';
import 'package:open_weather_map/provider/weather_provider.dart';
import 'package:provider/provider.dart';
import '../models/weather.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final Weather weather;

  const WeatherDetailsScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${weather.cityName}'s Weather",
          style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<WeatherProvider>(context, listen: false).clearWeather();
            Navigator.of(context).maybePop();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<WeatherProvider>(
            builder: (context, provider, child) {
              final isLoading = provider.isLoading;
              final error = provider.error;
              final updatedWeather = provider.weather;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    updatedWeather?.cityName ?? weather.cityName,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${updatedWeather?.temperature ?? weather.temperature}°C',
                    style: const TextStyle(fontSize: 32),
                  ),
                  Text(
                    updatedWeather?.description ?? weather.description,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Image.network(
                      'http://openweathermap.org/img/w/${updatedWeather?.icon ?? weather.icon}.png'),
                  Text(
                      'Humidity: ${updatedWeather?.humidity ?? weather.humidity}%'),
                  Text(
                      'Wind Speed: ${updatedWeather?.windSpeed ?? weather.windSpeed} m/s'),
                  if (isLoading) const CircularProgressIndicator(),
                  if (error != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: $error',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        elevation: 4, // Shadow
                      ),
                      onPressed: () async {
                        await provider.fetchWeather(weather.cityName);
                      },
                      child: const Text(
                        'Refresh',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
