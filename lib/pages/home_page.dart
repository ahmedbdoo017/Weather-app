import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/prviders/weather_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: weatherData == null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'there is no weather 😔 start',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    'searching now 🔍',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: Container(
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage(weatherData!.getImageWeather()),
                  //   fit: BoxFit.fill,
                  // ),
                  gradient: LinearGradient(
                    colors: [
                      weatherData!.getThemeColor(),
                      weatherData!.getThemeColor()[300]!,
                      weatherData!.getThemeColor()[100]!,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    Text(
                      //Provider.of<WeatherProvider>(context).cityName!,
                      weatherData!.city,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Updated at : ${weatherData!.date.hour}:${weatherData!.date.minute}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Spacer(flex: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(image: AssetImage(weatherData!.getIconWeather())),
                        Text(
                          '${weatherData!.temp.toInt()}',
                          style: const TextStyle(fontSize: 32),
                        ),
                        Column(
                          children: [
                            Text('Max: ${weatherData!.maxTemp.toInt()}'),
                            Text('Min: ${weatherData!.minTemp.toInt()}'),
                          ],
                        )
                      ],
                    ),
                    const Spacer(flex: 1),
                    Text(
                      weatherData!.weatherStateName,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(flex: 5),
                  ],
                ),
              ),
            ),
    );
  }
}
