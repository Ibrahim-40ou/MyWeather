import 'package:flutter/material.dart';
import 'package:my_weather/Widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../colors.dart';

class Day extends StatelessWidget {
  final List<String> time;
  final String temp;
  final String image;
  const Day({
    super.key,
    required this.time,
    required this.temp,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 100,
      width: 100.w,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: time[0],
                size: 16,
                weight: FontWeight.bold,
                color: Colors.white,
              ),
              MyText(
                text: '${time[1]}, ${time[2]}',
                size: 14,
                weight: FontWeight.normal,
                color: Colors.grey,
              ),
            ],
          ),
          MyText(
            text: '$temp°',
            size: 30,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
          Image.asset(image, height: 80, width: 80,)
        ],
      ),
    );
  }
}
