import 'package:clima/models/weather_model.dart';
import 'package:clima/pages/city_page.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, required this.weatherModel});

  final WeatherModel weatherModel;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String cityName = '';
  String temp = '';

  @override
  void initState() {
    super.initState();

    cityName = widget.weatherModel.city;
    temp = widget.weatherModel.temperature;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.near_me),
          onPressed: () async {
            Weather weather = Weather();
            WeatherModel weatherData =
                await weather.getWeatherUsingCurrentLocation();
            setState(() {
              cityName = weatherData.city;
              temp = weatherData.temperature;
            });
          },
        ),
        actions: [
          IconButton(
              onPressed: () async {
                String? city = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return const CityPage();
                }));
                if (city != null && city.isNotEmpty) {
                  Weather weather = Weather();
                  WeatherModel weatherData =
                      await weather.getWeatherUsingCityName(city);
                  setState(() {
                    temp = weatherData.temperature;
                    cityName = weatherData.city;
                  });
                }
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${temp}\u00B0C',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 150, fontWeight: FontWeight.w900),
              ),
              Text(
                cityName,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
