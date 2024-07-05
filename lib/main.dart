import 'package:flutter/material.dart';
import 'package:open_weather_map/provider/weather_provider.dart';
import 'package:open_weather_map/weather_details_screen.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';
import 'models/weather.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .loadLastCityWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, provider, child) {
        Weather? weather = provider.weather;
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 173, 167, 184)),
            useMaterial3: true,
          ),
          home: weather != null
              ? WeatherDetailsScreen(weather: weather)
              : HomeScreen(),
        );
      },
    );
  }
}
