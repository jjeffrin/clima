import 'package:clima/models/weather_model.dart';
import 'package:clima/pages/weather_page.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    getInitialWeatherData();
  }

  void getInitialWeatherData() async {
    Weather weather = Weather();
    try {
      WeatherModel weatherData = await weather.getWeatherUsingCurrentLocation();
      // the following condition check is made because: https://dart.dev/tools/linter-rules/use_build_context_synchronously
      if (context.mounted && mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WeatherPage(weatherModel: weatherData);
      }));
      }
    } catch (e) {
      print(e);
      _showWarningDialog();
    }
  }

  void _showWarningDialog() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Oops :/'),
                content: const Text(
                    'Please make sure the location services are enabled and permissions are provided.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Geolocator.openLocationSettings();
                      },
                      child: Text('OPEN LOCATION SETTINGS')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        getInitialWeatherData();
                      },
                      child: const Text('RETRY'))
                ],
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator.adaptive(),
          SizedBox(
            height: 20.0,
          ),
          Text('Please wait while we load data...')
        ],
      ),
    );
  }
}
