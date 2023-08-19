import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class Services {
  Future<WeatherData?> fetchWeatherData({required String city}) async {
    const apiKey = '723809c6c18f4143b2d74609231608';
    String url =
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&days=7&q=$city';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        return WeatherData.fromJson(data);
      } else {
        log('not getting');
      }
    } catch (e) {
      log('error');
    }
    return null;
  }
}
