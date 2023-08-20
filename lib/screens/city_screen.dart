import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;
  final FocusNode _textFieldFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city-bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    _textFieldFocusNode.unfocus();
                    // Delay the change using Future.delayed
                    Future.delayed(Duration(milliseconds: 500), () {
                      setState(() {
                        Navigator.pop(context, cityName);
                      });
                    });
                  },
                  child: Icon(
                    FontAwesomeIcons.caretLeft,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: TextField(
                    focusNode: _textFieldFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Enter City Name',
                      contentPadding: EdgeInsets.all(15.0),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        cityName = value;
                      });
                    },
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Get Weather',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Spartan MB',
                    color: Colors.white,
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
