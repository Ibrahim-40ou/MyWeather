import 'package:flutter/material.dart';
import 'package:my_weather/Widgets/text.dart';

class Statistic extends StatelessWidget {
  final String image;
  final String heading;
  final String info;
  const Statistic({
    super.key,
    required this.image,
    required this.heading,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 50,
          width: 50,
        ),
        MyText(
          text: heading,
          size: 16,
          weight: FontWeight.normal,
          color: Colors.grey,
        ),
        MyText(
          text: info,
          size: 16,
          weight: FontWeight.normal,
          color: Colors.white,
        ),
      ],
    );
  }
}
