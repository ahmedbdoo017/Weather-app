import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  String baseurl = 'http://api.weatherapi.com/v1';
  String apiKay = '72991a7160a348009f7162859232204';
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weather;
    try {
      Uri url =
          Uri.parse('$baseurl/forecast.json?key=$apiKay&q=$cityName&days=7');
      http.Response response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);
      weather = WeatherModel.fromjson(data);
    } catch (e) {
      print(e);
    }
    return weather;
  }
}
