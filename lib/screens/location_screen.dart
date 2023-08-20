import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:clima/services/weather.dart';

import "package:string_extensions/string_extensions.dart";

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final dynamic locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  WeatherModel weather = WeatherModel();

  late num temperature;
  late int condition;
  late String cityName;
  late String weatherIcon;
  late String status;
  late String? desc;

  void updateUI(dynamic weatherData) {
    // If the data is changing, setState() will be called
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        condition = 0;
        cityName = '';
        weatherIcon = 'Error';
        status = 'Unable to get weather data';
        return;
      } else {
        num temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        condition = weatherData['weather'][0]['id'];
        cityName = weatherData['name'];
        weatherIcon = weather.getWeatherIcon(condition);
        desc = weatherData['weather'][0]['description'];
        status = weather.getMessage(temp.toInt());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(1), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(top: 50.0, left: 15.0),
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          child: Marquee(
                                            text: cityName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat',
                                                color: Colors.white,
                                                fontSize: 25.0),
                                            scrollAxis: Axis.horizontal,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            blankSpace: 200.0,
                                            numberOfRounds:
                                                5, // Set to 0 for no gap between sentences
                                            velocity:
                                                50.0, // Adjust the speed of scrolling
                                            pauseAfterRound: Duration(
                                                seconds:
                                                    3), // Pause duration after each round
                                            startPadding:
                                                10.0, // Padding before starting
                                            accelerationDuration: Duration(
                                                seconds:
                                                    1), // Speed-up duration
                                            accelerationCurve:
                                                Curves.linear, // Speed-up curve
                                            decelerationDuration: Duration(
                                                seconds:
                                                    1), // Slow-down duration
                                            decelerationCurve: Curves
                                                .easeOut, // Slow-down curve
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding: EdgeInsets.only(left: 15.0),
                              alignment: Alignment.topRight,
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${temperature}°',
                                        style: TextStyle(
                                          fontSize: 150.0,
                                          fontFamily: 'JosefinSans',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 50.0, left: 30.0),
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                desc.capitalize!,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Spartan MB',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(
                        20), // Set the radius for rounded corners
                    border: Border.all(
                      color: Colors.white, // Set the border color
                      width: 2, // Set the border width
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(FontAwesomeIcons.locationArrow),
                                iconSize: 30.0,
                                color: Colors.white,
                                tooltip: 'Fetch Weather to current Location',
                                onPressed: () async {
                                  var weatherData =
                                      await weather.getLocationWeather();
                                  updateUI(weatherData);
                                },
                              ),
                              Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '11km',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Visibility',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(FontAwesomeIcons.city),
                                iconSize: 30.0,
                                color: Colors.white,
                                tooltip: 'Fetch Weather to current Location',
                                onPressed: () async {
                                  var typedCityName = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CityScreen(),
                                    ),
                                  );
                                  if (typedCityName != null) {
                                    var weatherData = await weather
                                        .getCityWeather(typedCityName);
                                    updateUI(weatherData);
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'City',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
