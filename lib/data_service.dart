import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models.dart';

class DataService {


  Future<WeatherResponse> getWeather(String cty) async {
    final queryParamaters = {
      'q': cty,
      'appid': '86231246cd0ac368123c234b7660dcc4',
      'units': 'metric'
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParamaters);
    final response = await http.get(uri);
    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }

  Future<WeatherResponseDays> getWeatherDays(String lat, String lon) async {
    final queryParamaters = {
      'lat': lat,
      'lon': lon,
      'exclude': 'hourly',
      'units': 'metric',
      'appid': '86231246cd0ac368123c234b7660dcc4',
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/onecall', queryParamaters);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    print(json);
    return WeatherResponseDays.fromJson(json);
  }
}
