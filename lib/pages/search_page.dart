import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/prviders/weather_provider.dart';

class SearchPage extends StatelessWidget {
  String? CityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sarch a City'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/night.webp'),
          fit: BoxFit.fill,
        )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (data) {
                CityName = data;
              },
              onSubmitted: (data) async {
                CityName = data;
                WeatherService service = WeatherService();
                WeatherModel? weather =
                    await service.getWeather(cityName: CityName!);
                Provider.of<WeatherProvider>(context, listen: false)
                    .weatherData = weather;
                Provider.of<WeatherProvider>(context, listen: false).cityName =
                    CityName;
                Navigator.pop(context);
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                border: const OutlineInputBorder(),
                hintText: 'Enter a City',
                labelText: 'Search',
                suffixIcon: IconButton(
                  onPressed: () async {
                    WeatherService service = WeatherService();
                    WeatherModel? weather =
                        await service.getWeather(cityName: CityName!);
                    Provider.of<WeatherProvider>(context, listen: false)
                        .weatherData = weather;
                    Provider.of<WeatherProvider>(context, listen: false)
                        .cityName = CityName;
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
