import 'package:flutter/material.dart';
import 'package:my_weather/Widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../colors.dart';

class City extends StatelessWidget {
  final String image;
  final String city;
  final String weather;
  final String temp;
  const City({
    super.key,
    required this.image,
    required this.city,
    required this.weather,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: MyColors().borderColor,
        ),
        color: MyColors().secondaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 70,
            width: 20.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: city,
                size: 16,
                weight: FontWeight.bold,
                color: Colors.white,
              ),
              MyText(
                text: weather,
                size: 14,
                weight: FontWeight.normal,
                color: Colors.grey,
              ),
            ],
          ),
          const MyText(
            text: '23°',
            size: 30,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
