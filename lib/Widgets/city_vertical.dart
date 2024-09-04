import 'package:flutter/material.dart';
import 'package:my_weather/Widgets/text.dart';
import '../colors.dart';

class CityVertical extends StatelessWidget {
  final String temp;
  final String main;
  final String location;
  final String image;
  const CityVertical({
    super.key,
    required this.temp,
    required this.main,
    required this.location,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: MyColors().borderColor,
        ),
        color: MyColors().secondaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: '$temp°',
                    size: 30,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 75,
                    child: MyText(
                      text: main,
                      size: 16,
                      weight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Image.asset(
                image,
                height: 80,
                width: 80,
              ),
            ],
          ),
          MyText(
            text: location,
            size: 16,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
