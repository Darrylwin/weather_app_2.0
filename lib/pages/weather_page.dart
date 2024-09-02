import 'package:flutter/material.dart';
import 'package:myapp/models/weather_model.dart';
import 'package:myapp/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService(
    apiKey: "d70b5ec9cea71ce1decd63f85e10e74c",
  );
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //any errors
    catch (e) {
      print(e);
    }

    //weather animation

    //init state
    @override
    void initState() {
      super.initState();

      //fetch weather on startup
      _fetchWeather();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "Loading city ..."),

            //temperature
            Text("${_weather?.temperature.round()}°c"),
          ],
        ),
      ),
    );
  }
}
