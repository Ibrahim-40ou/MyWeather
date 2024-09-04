import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_weather/Bindings/home_bindings.dart';
import 'package:my_weather/colors.dart';
import 'package:sizer/sizer.dart';

import 'View/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: MyColors().mainColor),
  );

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        locale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
        getPages: [
          GetPage(
            name: '/',
            page: () => const Home(),
            binding: HomeBindings(),
          ),
        ],
      ),
    ),
  );
}
