import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';

const appKey = '4182e69b874da4c40d17f30386c61de5';

class WeatherModel {
  double latitude = 0;
  double longitude = 0;

  Future<dynamic> getLocationWeather() async {
    location userLocation = location();
    await userLocation.getLocation();
    latitude = userLocation.latitude;
    longitude = userLocation.longitude;
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'appid': appKey,
      'units': 'metric'
    });

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'q': cityName, 'appid': appKey, 'units': 'metric'});

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();

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
