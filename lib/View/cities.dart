import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_weather/Controllers/home_controller.dart';
import 'package:my_weather/colors.dart';

import '../Widgets/text.dart';

class Cities extends StatelessWidget {
  const Cities({super.key});

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
                text: 'Cities',
                size: 20,
                weight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            body: controller.fetchingCountriesData
                ? Center(
                    child: CircularProgressIndicator(
                      color: MyColors().selectedColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: controller.items,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
