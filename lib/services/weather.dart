import 'package:clima/models/weather_model.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/network.dart';
import 'package:geolocator/geolocator.dart';

class Weather {
  final String _authority = 'api.openweathermap.org';
  final String _unencodedPath = '/data/2.5/weather';
  final String _appId = '9a5e8137beb63b093ed352c45825a556';

  Future<WeatherModel> getWeatherUsingCurrentLocation() async {
    Location locationManager = Location();
    Network networkHelper = Network();
    try {
      Position pos = await locationManager.getLocation();
      Map<String, dynamic> response =
          await networkHelper.fetch(_authority, _unencodedPath, {
        'lat': pos.latitude.toString(),
        'lon': pos.longitude.toString(),
        'units': 'metric',
        'appid': _appId
      });
      return Future.value(WeatherModel(
          temperature: response["main"]["temp"].toInt().toString(),
          city: response["name"].toString()));
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<WeatherModel> getWeatherUsingCityName(String cityName) async {
    Network networkHelper = Network();
    try {
      Map<String, dynamic> response = await networkHelper.fetch(_authority,
          _unencodedPath, {'q': cityName, 'units': 'metric', 'appid': _appId});
      return Future.value(WeatherModel(
          temperature: response["main"]["temp"].toInt().toString(),
          city: response["name"].toString()));
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
