import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import './currentLocation.dart';
import './model.dart';
import './service.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.white,
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<WeatherModel> weather;
  double latitude;
  double longitude;

  @override
  void initState() {
    getCurrentLocationWeather();
    super.initState();
  }

  Future getCurrentLocationWeather() async {
    Position position = await getCurrentLocation();
    latitude = position.latitude;
    longitude = position.longitude;
    weather = getWeather(latitude.toString(), longitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double temperature = snapshot.data.temperature - 273.15;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${snapshot.data.timeZone}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 50,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  centerWidget(
                    heading: 'Temperature:',
                    value: '${temperature.toStringAsFixed(1)} \u00B0C',
                  ),
                  centerWidget(
                      heading: 'Weather: ',
                      value: '${snapshot.data.description}'),
                  centerWidget(
                      heading: 'Wind Speed: ',
                      value: '${snapshot.data.windSpeed} km\\h'),
                  centerWidget(
                    heading: 'Pressure: ',
                    value: '${snapshot.data.pressure} Pascal',
                  ),
                  centerWidget(
                      heading: 'Humidity: ',
                      value: '${snapshot.data.humidity} g.kg-1'),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Refresh',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                         getCurrentLocationWeather();
                        });
                      })
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        },
      ),
    );
  }
}

Widget centerWidget({String heading, String value}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: 36,
          ),
        ),
        Text(
          value,
          style: kTextStyle,
        ),
      ],
    ),
  );
}

Widget _appBar = AppBar(
  elevation: 0.0,
  centerTitle: true,
  title: RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: 'Cloud',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        TextSpan(
          text: 'Cover',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18.0,
          ),
        ),
      ],
    ),
  ),
);

final TextStyle kTextStyle = TextStyle(
  color: Colors.blue,
  fontSize: 30,
  fontWeight: FontWeight.w400,
);
