class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'], //! {"name": "Delhi"},
      temperature: json['main']['temp'], // ! {"main":{"temp":32.84}}
      description: json['weather'][0][
          'description'], //!{"weather":[{0},{},{}]} ==> 0th {"description": "haze",}
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }
}
