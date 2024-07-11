import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/size_config.dart';

class ForecastDataView extends StatelessWidget {
  final RxList<List<String>> forecastData;
  final bool isHourlyData;
  const ForecastDataView(
      {required this.forecastData, required this.isHourlyData, super.key});

  @override
  Widget build(BuildContext context) {
    double width;
    double height;

    if (MediaQuery.of(context).size.width < 600) {
      width = MediaQuery.of(context).size.width * 0.16;
      height = MediaQuery.of(context).size.height * 0.15;
    } else {
      width = MediaQuery.of(context).size.width * 0.11;
      height = MediaQuery.of(context).size.height * 0.16;
    }

    return Center(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: forecastData.map((weather) {
            int minTemp = 0;
            int maxTemp = 0;

            double temperature = double.parse(weather[1]);

            if (!isHourlyData) {
              minTemp = double.parse(weather[1]).toInt();
              maxTemp = double.parse(weather[2]).toInt();
            }

            var icon = temperature < 27.0
                ? Icons.cloudy_snowing
                : temperature < 30.0
                    ? Icons.cloud
                    : weather[0].split(' ').last.toUpperCase() == "AM"
                        ? Icons.sunny
                        : Icons.nights_stay;

            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  tileMode: TileMode.mirror,
                  colors: [
                    Color.fromARGB(50, 107, 66, 255),
                    Color.fromARGB(255, 72, 49, 157),
                  ],
                ),
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: Colors.blueAccent, width: 2.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    weather[0].toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.textSizeMedium,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    icon,
                    size: SizeConfig.iconSizeLarge,
                    color: Colors.white,
                  ),
                  isHourlyData
                      ? Text(
                          "$temperature°",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.textSizeMedium,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "$minTemp°/$maxTemp°",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.textSizeMedium,
                              fontWeight: FontWeight.bold),
                        ),
                ],
              ),
            );
          }).toList()),
    );
  }
}
