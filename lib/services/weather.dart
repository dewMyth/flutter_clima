import 'package:clima/services/weather.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    LocationService location = LocationService();
    await location.getCurrentLocation();
    num lat = location.latitude;
    num lon = location.longitude;

    final String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=61d04b20030c94aae86b21b1fd3e087b&units=metric';

    HttpService weather = HttpService(url);

    var weatherData = await weather.getData();
    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=61d04b20030c94aae86b21b1fd3e087b&units=metric';

    HttpService weather = HttpService(url);

    var weatherData = await weather.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
