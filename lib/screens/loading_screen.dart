import 'package:flutter/material.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';


//Question marks below are a sign that these variables are nullable (can be null at this stage).
// double? latitude;
// double? longitude;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getLocationData();

  }
  //I used async because this is a time-consuming task (getting location), so to avoid running this task in the foreground and cause lagging or crashing.
  void getLocationData() async {
    // WeatherModel weatherModel = WeatherModel();
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          size: 100.0,
          color: Colors.white,
        ),
      ),

    );
  }
}