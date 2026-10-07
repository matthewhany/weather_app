import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> getWeather(String city) async {
    final url = Uri.parse(
      'https://api.weatherapi.com/v1/forecast.json'
      '?key=${ApiConfig.apiKey}'
      '&q=$city'
      '&days=3',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return WeatherModel.fromJson(data);
      } else if (response.statusCode == 400) {
        throw Exception('City not found');
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key');
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      if (e.toString().contains('SocketException') ||
          e.toString().contains('ClientException')) {
        throw Exception(
          'No Internet Connection. Please check your internet and try again.',
        );
      }

      rethrow;
    }
  }
}