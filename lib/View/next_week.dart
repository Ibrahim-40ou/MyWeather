import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_weather/Controllers/home_controller.dart';
import 'package:my_weather/Widgets/day.dart';
import 'package:my_weather/colors.dart';

import '../Widgets/text.dart';

class NextWeek extends StatelessWidget {
  const NextWeek({super.key});

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
              leading: IconButton(
                onPressed: Get.back,
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              centerTitle: true,
              title: const MyText(
                text: 'Next Week',
                size: 20,
                weight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: ListView.builder(
                itemCount: controller.dailyForecast.length,
                itemBuilder: (context, index) {
                  return Day(
                    time: DateFormat('EEEE MMM d')
                        .format(
                          DateTime.fromMillisecondsSinceEpoch(
                            controller.dailyForecast[index]['dt'] * 1000,
                          ),
                        )
                        .split(' '),
                    temp: controller.dailyForecast[index]['temp']['max']
                        .toInt()
                        .toString(),
                    image: controller.determineIcon(
                      controller.dailyForecast[index]['weather'][0]['main'],
                      true,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
