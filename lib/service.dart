import 'dart:convert';

import 'package:http/http.dart' as http;

import './model.dart';

Future<WeatherModel> getWeather(String latitude,String longitude) async {
  final response = await http.get(
      'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude={part}&appid=8816edade9e940ce357d6c8633cb2352');
  if (response.statusCode == 200) {
    final data = WeatherModel.fromJson(jsonDecode(response.body));
    return data;
  } else {
    throw Exception('No Data');
  }
}
