import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:tracking_flutter/models/weather.dart';

class WeatherService{
  fecthWeather() async {
    final response = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=-7.6298999&lon=111.5171143&appid=a1c22ee3529feb8e43d3c78fee352349"
        ));
    try{
      if(response.statusCode == 200){
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception("failed to load weather data");
      }
    } catch(e){
      print(e.toString());
    }
  }
}