Flutter Weather App

A simple weather application built with Flutter and Dart using WeatherAPI.com.

Features

- Search for any city.
- Show current temperature and weather condition.
- Show weather icon.
- Show feels-like temperature, humidity, and wind speed.
- Show a 3-day forecast.
- Loading indicator while fetching weather data.
- Friendly error messages.
- Remember the last searched city.

Technologies

- Flutter & Dart
- WeatherAPI.com
- HTTP
- Shared Preferences

Project Structure

lib/
├── config/
│   └── api_config.dart
├── models/
│   └── weather_model.dart
├── screens/
│   └── weather_screen.dart
├── services/
│   └── weather_service.dart
└── main.dart

How to Run

1. Install Flutter.
2. Get a WeatherAPI.com API key.
3. Add your API key to:

lib/config/api_config.dart

Example:

class ApiConfig {
static const String apiKey = 'YOUR_API_KEY';
}

4. Run:

flutter pub get
flutter run

Screenshots

Screenshots of the application are available in the "screenshots" folder.

Demo

A short screen recording demonstrates the main features of the application.

Prompt Log

Prompt 1

Create a simple Flutter Weather App using WeatherAPI.com with a clean UI and separate folders for models, services, screens, and configuration.

Prompt 2

Create Dart model classes to parse the WeatherAPI JSON response for current weather and a 3-day forecast.

Prompt 3

Create a WeatherService using the HTTP package to request forecast data from WeatherAPI.com using the forecast endpoint with days=3.

Prompt 4

Add a city search field that allows the user to search for a city and display its weather.

Prompt 5

Add loading and friendly error messages for no internet connection, city not found, invalid API key, and other API errors.

Prompt 6

Use SharedPreferences to save the last searched city and load it automatically when the application starts.

Prompt 7

Review the Weather App and make sure it meets the project requirements without unnecessary changes.

Failed Prompt

One prompt initially caused Dart errors because Markdown code fences were accidentally copied into a Dart file. The issue was fixed by removing the Markdown fences and keeping only the Dart code.