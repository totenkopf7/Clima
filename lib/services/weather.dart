import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

String openWeatherURL = "https://api.openweathermap.org/data/2.5/weather";
String apiKey = "1e379316d41238a0e2896779eae5c6af";

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    var url = "$openWeatherURL?q=$cityName&appid=$apiKey&units=metric";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var weatherData = await networkHelper.getData();
    return weatherData;

  }

  Future<dynamic> getLocationWeather() async {
    Location newLocation = Location();
    await newLocation.getCurrentLocation(); // Wait for the location data to be available.
    NetworkHelper networkhelper = NetworkHelper(url: "$openWeatherURL?lat=${newLocation.latitude}&lon=${newLocation.longitude}&appid=$apiKey&units=metric");
    var weatherData = await networkhelper.getData();
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
