class WeatherModel {
  final String city;
  final String country;
  final double temperature;
  final String condition;
  final String icon;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final List<ForecastDay> forecast;

  WeatherModel({
    required this.city,
    required this.country,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    List forecastList = json['forecast']['forecastday'];

    return WeatherModel(
      city: json['location']['name'],
      country: json['location']['country'],
      temperature: (json['current']['temp_c'] as num).toDouble(),
      condition: json['current']['condition']['text'],
      icon: json['current']['condition']['icon'],
      feelsLike: (json['current']['feelslike_c'] as num).toDouble(),
      humidity: json['current']['humidity'],
      windSpeed: (json['current']['wind_kph'] as num).toDouble(),

      forecast: forecastList
          .map((day) => ForecastDay.fromJson(day))
          .toList(),
    );
  }
}

class ForecastDay {
  final String date;
  final String condition;
  final String icon;
  final double minTemp;
  final double maxTemp;

  ForecastDay({
    required this.date,
    required this.condition,
    required this.icon,
    required this.minTemp,
    required this.maxTemp,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'],
      condition: json['day']['condition']['text'],
      icon: json['day']['condition']['icon'],
      minTemp: (json['day']['mintemp_c'] as num).toDouble(),
      maxTemp: (json['day']['maxtemp_c'] as num).toDouble(),
    );
  }
}