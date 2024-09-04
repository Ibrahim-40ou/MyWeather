import 'package:flutter/material.dart';
import 'package:my_weather/Widgets/text.dart';
import 'package:my_weather/colors.dart';

class Time extends StatelessWidget {
  final String temp;
  final String image;
  final String time;
  final bool isSelected;
  final Function function;
  const Time({
    super.key,
    required this.temp,
    required this.image,
    required this.time,
    this.isSelected = false, required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: isSelected ? MyColors().selectedColor :MyColors().secondaryColor,
      elevation: 0,
      minWidth: 80,
      padding: EdgeInsets.zero,
      shape: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: MyColors().borderColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: () {
        function();
      },
      child: SizedBox(
        height: 110,
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: MyText(
                  text: temp,
                  size: 16,
                  weight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
            Image.asset(
              image,
              height: 50,
              width: 50,
            ),
            MyText(
              text: time,
              size: 16,
              weight: FontWeight.normal,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
