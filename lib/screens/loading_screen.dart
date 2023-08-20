// Libraries
import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Services
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double lat;
  late double lon;

  void getWeatherByCurrentLocation() async {
    WeatherModel weather = WeatherModel();
    var weatherData = await weather.getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather: weatherData);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getWeatherByCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
