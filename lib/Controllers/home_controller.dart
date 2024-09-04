import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:my_weather/Widgets/city_vertical.dart';

class HomeController extends GetxController {
  bool fetchingCountriesData = false;
  @override
  void onInit() async {
    super.onInit();
    await fetchBaghdadWeather();
    fetchingCountriesData = true;
    update();
    await getCurrentWeatherByLocation(133.7751, -25.2744, 'Australia');
    await getCurrentWeatherByLocation(8.2275, 46.8182, 'Switzerland');
    await getCurrentWeatherByLocation(-7.0926, 31.7917, 'Morocco');
    await getCurrentWeatherByLocation(46.2276, 2.2137, 'France');
    fetchingCountriesData = false;
    update();
    makeItems();
    getKeys();
  }

  final apiKey = '5648a4f1216846af135a942d44f50991';
  final baseUrl = 'https://api.openweathermap.org/data/3.0/onecall';
  late Map<String, dynamic> data = {};
  late Map<String, dynamic> currentWeather = {};
  late List<Map<String, dynamic>> hourlyForecast = [];
  late List<Map<String, dynamic>> dailyForecast = [];
  bool fetchingData = false;
  Future<void> fetchBaghdadWeather() async {
    fetchingData = true;
    update();
    const lat = 33.3153;
    const lon = 44.3942;

    final uri = Uri.parse(
        '$baseUrl?lat=$lat&lon=$lon&exclude=minutely,alerts&units=metric&appid=$apiKey');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      currentWeather = data['current'];
      hourlyForecast = data['hourly'].cast<Map<String, dynamic>>();
      dailyForecast = data['daily'].cast<Map<String, dynamic>>();
      countryData['Baghdad'] = currentWeather;
      fetchingData = false;
      update();
    } else {
      fetchingData = false;
      update();
      throw Exception('Failed to load weather data.');
    }
  }

  bool isDaytime(int dt, int sunrise, int sunset) {
    final currentTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    final sunriseTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    final sunsetTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);

    if (sunsetTime.isBefore(sunriseTime)) {
      return currentTime.isAfter(sunriseTime) ||
          currentTime.isBefore(
            sunsetTime.add(
              const Duration(days: 1),
            ),
          );
    } else {
      return currentTime.isAfter(sunriseTime) &&
          currentTime.isBefore(sunsetTime);
    }
  }

  String determineIcon(String condition, bool isDaytime) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return isDaytime ? 'assets/clear.png' : 'assets/clear_night.png';
      case 'clouds':
        return isDaytime ? 'assets/clouded.png' : 'assets/clouded_night.png';
      case 'rain':
        return isDaytime ? 'assets/raining.png' : 'assets/raining_night.png';
      case 'thunderstorm':
        return isDaytime
            ? 'assets/thunderstorm.png'
            : 'assets/thunderstorm_night.png';
      default:
        return 'assets/clouded.png';
    }
  }

  final Map<String, Map<String, dynamic>> countryData = {};
  Future<void> getCurrentWeatherByLocation(
    double lon,
    double lat,
    String countryName,
  ) async {
    final uri = Uri.parse(
        '$baseUrl?lat=$lat&lon=$lon&exclude=minutely,hourly,daily,alerts&appid=$apiKey&units=metric');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      countryData[countryName] = data;
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  List<Widget> items = [];
  void makeItems() {
    for (String countryName in countryData.keys) {
      if (countryName == 'Baghdad') {
        items.add(
          CityVertical(
            temp: countryData[countryName]?['temp'].toInt().toString() ?? '',
            main: countryData[countryName]?['weather'][0]['main'] ?? '',
            location: countryName,
            image: determineIcon(
              countryData[countryName]?['weather'][0]['main'],
              true,
            ),
          ),
        );
      } else {
        items.add(
          CityVertical(
            temp: countryData[countryName]?['current']['temp']
                    .toInt()
                    .toString() ??
                '',
            main: countryData[countryName]?['current']['weather'][0]['main'] ??
                '',
            location: countryName,
            image: determineIcon(
              countryData[countryName]?['current']['weather'][0]['main'],
              true,
            ),
          ),
        );
      }
      update();
    }
  }

  List<String> keys = [];
  void getKeys() {
    for (String key in countryData.keys) {
      keys.add(key);
    }
    update();
  }

  int selectedIndex = -1;
  void selectButton(int index) {
    selectedIndex = index;
    update();
  }
}
