import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_weather/Controllers/home_controller.dart';
import 'package:my_weather/View/cities.dart';
import 'package:my_weather/View/next_week.dart';
import 'package:my_weather/Widgets/city.dart';
import 'package:my_weather/Widgets/statistic.dart';
import 'package:my_weather/Widgets/text.dart';
import 'package:my_weather/Widgets/time.dart';
import 'package:my_weather/colors.dart';
import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: MyColors().mainColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              forceMaterialTransparency: true,
              leading: null,
              centerTitle: true,
              title: const MyText(
                text: 'Today',
                size: 20,
                weight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            body: controller.fetchingData
                ? Center(
                    child: CircularProgressIndicator(
                      color: MyColors().selectedColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedOpacity(
                              opacity: controller.fetchingData ? 0.0 : 1.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                              child: MyText(
                                text: controller.fetchingData
                                    ? ''
                                    : '${controller.currentWeather['temp'].toInt()}°',
                                size: 50,
                                weight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const MyText(
                                  text: 'Baghdad',
                                  size: 20,
                                  weight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                MyText(
                                  text: DateFormat('EEEE, MMM d')
                                      .format(DateTime.now()),
                                  size: 16,
                                  weight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Image.asset(
                            controller.determineIcon(
                              controller.currentWeather['weather'][0]['main'],
                              controller.isDaytime(
                                controller.currentWeather['dt'],
                                controller.currentWeather['sunrise'],
                                controller.currentWeather['sunset'],
                              ),
                            ),
                            height: 20.h,
                            width: 100.w,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Statistic(
                              image: 'assets/wind.png',
                              heading: 'Wind',
                              info:
                                  '${(controller.currentWeather['wind_speed'] * 3.6).toInt().toString()} km',
                            ),
                            Statistic(
                              image: 'assets/visibility.png',
                              heading: 'Visibility',
                              info:
                                  '${(controller.currentWeather['visibility'] / 1000).toInt().toString()} km',
                            ),
                            Statistic(
                              image: 'assets/humidity.png',
                              heading: 'Humidity',
                              info:
                                  '${(controller.currentWeather['humidity']).toInt().toString()}%',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const MyText(
                              text: 'Today',
                              size: 16,
                              weight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => const NextWeek(),
                                );
                              },
                              child: const MyText(
                                text: 'Next 7 Days >',
                                size: 14,
                                weight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 110,
                          width: 100.w,
                          child: controller.fetchingData
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: MyColors().selectedColor,
                                  ),
                                )
                              : ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      min(controller.hourlyForecast.length, 24),
                                  itemBuilder: (context, index) {
                                    return Time(
                                      function: () {
                                        controller.selectButton(index);
                                      },
                                      temp: controller.hourlyForecast[index]
                                              ['temp']
                                          .toInt()
                                          .toString(),
                                      image: controller.determineIcon(
                                        controller.hourlyForecast[index]
                                            ['weather'][0]['main'],
                                        controller.isDaytime(
                                          controller.hourlyForecast[index]
                                              ['dt'],
                                          controller.currentWeather['sunrise'],
                                          controller.currentWeather['sunset'],
                                        ),
                                      ),
                                      time: DateFormat('HH:mm').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                          controller.hourlyForecast[index]
                                                  ['dt'] *
                                              1000,
                                        ),
                                      ),
                                      isSelected: controller.selectedIndex == index,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 10,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const MyText(
                              text: 'Other Cities',
                              size: 16,
                              weight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const Cities());
                              },
                              child: const MyText(
                                text: 'See All >',
                                size: 14,
                                weight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 110,
                          width: 100.w,
                          child: controller.fetchingCountriesData
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: MyColors().selectedColor,
                                  ),
                                )
                              : ListView.separated(
                                  itemCount: min(controller.items.length, 3),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return City(
                                      image: controller.determineIcon(
                                        controller.countryData[
                                                controller.keys[index + 1]]
                                            ?['current']['weather'][0]['main'],
                                        true,
                                      ),
                                      city: controller.keys[index + 1],
                                      temp: controller.countryData[controller
                                                  .keys[index + 1]]!['current']
                                              ['temp']
                                          .toInt()
                                          .toString(),
                                      weather: controller.countryData[
                                              controller.keys[index + 1]]
                                          ?['current']['weather'][0]['main'],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
