import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController cityController = TextEditingController();

  final WeatherService weatherService = WeatherService();

  WeatherModel? weather;

  bool isLoading = false;

  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    loadLastCity();
  }

  Future<void> loadLastCity() async {
    final prefs = await SharedPreferences.getInstance();

    final lastCity = prefs.getString('lastCity') ?? 'Cairo';

    cityController.text = lastCity;

    getWeather(lastCity);
  }

  Future<void> getWeather(String city) async {
    if (city.trim().isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final result = await weatherService.getWeather(city.trim());

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('lastCity', city.trim());

      setState(() {
        weather = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // Search Bar

            TextField(
              controller: cityController,

              decoration: InputDecoration(
                hintText: 'Enter city name',

                suffixIcon: IconButton(
                  onPressed: () {
                    getWeather(cityController.text);
                  },

                  icon: const Icon(Icons.search),
                ),

                border: const OutlineInputBorder(),
              ),

              onSubmitted: (value) {
                getWeather(value);
              },
            ),

            const SizedBox(height: 20),

            // Loading

            if (isLoading)
              const CircularProgressIndicator(),

            // Error

            if (!isLoading && errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),

            // Weather

            if (!isLoading && errorMessage.isEmpty && weather != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      // City

                      Text(
                        '${weather!.city}, ${weather!.country}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Temperature

                      Text(
                        '${weather!.temperature.round()}°C',
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Weather Icon

                      Image.network(
                        'https:${weather!.icon}',
                        width: 100,
                        height: 100,
                      ),

                      // Condition

                      Text(
                        weather!.condition,
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Details

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,

                        children: [
                          weatherDetail(
                            'Feels like',
                            '${weather!.feelsLike.round()}°C',
                          ),

                          weatherDetail(
                            'Humidity',
                            '${weather!.humidity}%',
                          ),

                          weatherDetail(
                            'Wind',
                            '${weather!.windSpeed} km/h',
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        '3-Day Forecast',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Forecast

                      Row(
                        children: weather!.forecast.map(
                              (day) {
                            return Expanded(
                              child: forecastCard(day),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget weatherDetail(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget forecastCard(ForecastDay day) {
    return Card(
      margin: const EdgeInsets.all(4),

      child: Padding(
        padding: const EdgeInsets.all(8),

        child: Column(
          children: [
            Text(
              day.date,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Image.network(
              'https:${day.icon}',
              width: 50,
              height: 50,
            ),

            Text(
              day.condition,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              '${day.minTemp.round()}° / ${day.maxTemp.round()}°',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}