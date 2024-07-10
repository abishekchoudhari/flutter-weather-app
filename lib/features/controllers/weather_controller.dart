import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/network/remote_service.dart';
import '../../core/utils/permission_handler.dart';
import '../models/weather_forecast_model.dart';

class WeatherController extends GetxController {
  final RemoteService _remoteService = RemoteService();

  late TabController tabController;
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  RxBool isLoading = true.obs;
  late List<Hourly> perHourData;
  late List<Daily> dayData;
  Rx<WeatherForecastModel> weatherForecastData = WeatherForecastModel().obs;
  RxList<List<String>> hourlyDataList = <List<String>>[].obs;
  RxList<List<String>> hourlyData = <List<String>>[].obs;
  RxList<List<String>> dailyData = <List<String>>[].obs;

  late bool isLocationGranted;
  late Position? location;

  @override
  void onInit() async {
    isLocationGranted =
        await PermissionHandler.checkAndRequestLocationPermission();
    if (isLocationGranted) {
      location = await Geolocator.getCurrentPosition();
    } else {
      location = await Geolocator.getLastKnownPosition();
    }
    await getWeatherReport();
    //animationController.forward();
    super.onInit();
  }

  Future<void> getWeatherReport() async {
    DateTime now = DateTime.now();

    hourlyData.clear();
    dailyData.clear();

    var response = await _remoteService.weatherReport(
        "${location?.latitude},${location?.longitude}",
        "");
    weatherForecastData.value = weatherForecastModelFromJson(response.body);

    weatherForecastData.value.timelines!.hourly!.mapMany((data) {
      if (formatDate(data.time!.toLocal()) == formatDate(DateTime.now())) {
        hourlyDataList.add([
          formatTime(data.time!.toLocal()),
          data.values!["temperature"].toString()
        ]);
      }
      return;
    }).toList();

    perHourData = weatherForecastData.value.timelines!.hourly!
        .where((data) {
          DateTime utcDateTime = DateTime.parse(data.time.toString());
          DateTime localDateTime = utcDateTime.toLocal();
          return localDateTime.isAfter(now);
        })
        .take(5)
        .toList();
    dayData = weatherForecastData.value.timelines!.daily!.take(5).toList();

    perHourData
        .map((data) => hourlyData.add([
              formatTime(data.time!.toLocal()),
              data.values!["temperature"].toString(),
            ]))
        .toList();

    dayData
        .map((data) => dailyData.add([
              formatDate(data.time!),
              data.values!.temperatureMin.toString(),
              data.values!.temperatureMax.toString()
            ]))
        .toList();

    isLoading.value = false;
    update();
  }

  String formatTime(DateTime dateTime) {
    return DateFormat.j().format(dateTime);
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM')
        .format(dateTime); // Format to display date and month
  }

  void initControllers(TickerProvider tickerProvider) {
    tabController = TabController(length: 2, vsync: tickerProvider);
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1300),
      vsync: tickerProvider,
    );
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ));

    // Start the animation
    animationController.forward();
  }

  @override
  void onClose() {
    //tabController.dispose();
    //animationController.dispose();
    super.onClose();
  }
}
