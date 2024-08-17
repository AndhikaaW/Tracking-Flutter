import 'package:flutter/material.dart';
import 'package:tracking_flutter/models/weather.dart';
import 'package:tracking_flutter/services/weater_services.dart';

class MyWeather extends StatefulWidget {
  const MyWeather({super.key});

  @override
  State<MyWeather> createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  late WeatherData weatherInfo;
  myWeather(){
    WeatherService().fecthWeather().then((value){
      setState(() {
        weatherInfo = value;
      });
    });
  }
  @override
  void initState() {
    myWeather();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: WeatherDetail(weather: weatherInfo))],
        ),
      ),
    );
  }
}
class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  const WeatherDetail({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(weather.name,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight:FontWeight.bold
          ),
        ),
        Text(
          "${weather.temperature.current.toStringAsFixed(2)}°C",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight:FontWeight.bold
          ),
        )
      ],
    );
  }
}

