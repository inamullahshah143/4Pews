import 'dart:async';

import 'package:admin/responsive/desktop_body.dart';
import 'package:admin/responsive/mobile_body.dart';
import 'package:admin/responsive/responsive_layout.dart';
import 'package:admin/responsive/tablet_body.dart';
import 'package:admin/util/constant.dart';
import 'package:admin/util/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileBody: MobileScaffold(),
              tabletBody: TabletScaffold(),
              desktopBody: DesktopScaffold(),
            ),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              assetsPath + "splash_icon.png",
              height: getScreenPercentSize(context, 12),
              color: Colors.white,
            ),
            SizedBox(
              height: getScreenPercentSize(context, 1.2),
            ),
            Center(
              child: getSplashTextWidget(
                  "4Paws",
                  Colors.white,
                  getScreenPercentSize(context, 4),
                  FontWeight.w500,
                  TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
