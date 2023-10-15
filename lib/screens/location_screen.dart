import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:flutter/services.dart';



class LocationScreen extends StatefulWidget {
  LocationScreen({required this.locationWeather});
  final locationWeather;


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  int? cTemperature;
  int? condition;
  String? city;
  String? weatherIcon;
  String? weatherMessage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  updateUI(Map<String, dynamic>? weatherData){
    setState(() {
      if (weatherData == null){
        cTemperature = 0;
        weatherIcon = "Error";
        weatherMessage = "Unable to get weather data";
        city = "";
        return;
      }
      double temp = weatherData["main"]["temp"].toDouble();
      cTemperature = temp.toInt();
      condition = weatherData["weather"][0]["id"];
      city = weatherData["name"];
      weatherIcon = weatherModel.getWeatherIcon(condition!);
      weatherMessage = weatherModel.getMessage(cTemperature!);
    });
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                          var weatherData = await weatherModel.getLocationWeather();
                          updateUI(weatherData);
                      },
                      
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        //The holded value from screen 2(cityName) gets back here to be used.
                        var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CityScreen();
                        })
                        );
                        if (typedName!=null) {
                          var weatherData = await weatherModel.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 125,),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(

                    children: <Widget>[
                      Text(

                        "$cTemperature°C",
                        style: kTempTextStyle,
                      ),
                      SizedBox(width: 25,),
                      Text(
                        "$weatherIcon",
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 75,),
                Padding(

                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    "$weatherMessage in $city",
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
