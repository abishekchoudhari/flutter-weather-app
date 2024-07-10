import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/weather_controller.dart';
import '../../core/utils/size_config.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
    with TickerProviderStateMixin {
  late WeatherController weatherController;

  @override
  void initState() {
    super.initState();
    weatherController = Get.put(WeatherController());
    weatherController.initControllers(this);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            _buildCurrentForecastSection(),
            _buildForecastSection(context),
          ],
        ),
    );
  }

  Widget _buildCurrentForecastSection() {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Pune",
            style: TextStyle(
                fontSize: SizeConfig.textSizeExtraLarge, color: Colors.white),
          ),
          Text(
            "19°",
            style: TextStyle(
              fontSize: SizeConfig.textSizeVeryLarge,
              color: Colors.white,
              fontWeight: FontWeight.w100,
            ),
          ),
          Text(
            "Mostly clear",
            style: TextStyle(
                fontSize: SizeConfig.textSizeLarge, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastSection(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/house_image.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: weatherController.slideAnimation,
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 46, 51, 90),
                        Color.fromARGB(255, 28, 27, 51)
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildTabBar(),
                      _buildTabBarView(),
                      _buildBottomIcons(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: weatherController.tabController,
      labelColor: Colors.white,
      dividerColor: Colors.transparent,
      tabs: [
        Tab(
          child: Text(
            "Today's Hourly Forecast",
            style: TextStyle(fontSize: SizeConfig.textSizeSmall),
          ),
        ),
        Tab(
          child: Text(
            "Daily Forecast",
            style: TextStyle(fontSize: SizeConfig.textSizeSmall),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBarView() {
    return Expanded(
      flex: 3,
      child: Obx(
        () => weatherController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                controller: weatherController.tabController,
                children: [
                  // Hourly Forecast Tab View
                  ForecastDataView(
                    forecastData: weatherController.hourlyData,
                    isHourlyData: true,
                  ),
                  // Daily Forecast Tab View
                  ForecastDataView(
                    forecastData: weatherController.dailyData,
                    isHourlyData: false,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildBottomIcons(BuildContext context) {
    return Expanded(
      flex: 1,
      child: CustomPaint(
        painter: TopCurvePainter(context: context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomIconButton(
                onPressed: () {}, iconData: Icons.location_on_outlined),
            CustomIconButton(
              onPressed: () {},
              iconData: Icons.search,
              iconSize: SizeConfig.iconSizeVeryLarge,
            ),
            CustomIconButton(
                onPressed: () {
                  showHourlyDataDialog();
                },
                iconData: Icons.list_outlined),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    weatherController.onClose();
    super.dispose();
  }

  showHourlyDataDialog() {
    return showModalBottomSheet(
      backgroundColor: const Color.fromARGB(143, 134, 44, 207),
      useSafeArea: true,
      context: context,
      builder: (context) => ListView.builder(
        itemCount: weatherController.hourlyDataList.length,
        itemBuilder: (context, index) {
          double temp =
              double.parse(weatherController.hourlyDataList[index][1]);
          var icon = temp < 27.0
              ? Icons.cloudy_snowing
              : temp < 30.0
                  ? Icons.cloud
                  : weatherController.hourlyDataList[index][0]
                              .split(' ')
                              .last
                              .toUpperCase() ==
                          "AM"
                      ? Icons.sunny
                      : Icons.nights_stay;

          return Container(
            height: context.height / 4,
            padding: const EdgeInsets.all(20),
            child: CustomPaint(
              painter: BottomSheetPainter(),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      icon,
                      size: SizeConfig.iconSizeVeryExtraLarge,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weatherController.hourlyDataList[index][0],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.textSizeDoubleExtraLarge),
                        ),
                        Text(
                          "${weatherController.hourlyDataList[index][1]}°",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.textSizeExtraLarge),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
