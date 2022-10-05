import 'package:flutter/material.dart';
import 'package:four_pews/utils/constant.dart';
import 'package:four_pews/utils/custom_widget.dart';
import 'package:four_pews/utils/size_config.dart';

import 'phone_verification.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPage createState() {
    return _ForgotPasswordPage();
  }
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  int themeMode = 0;
  TextEditingController phoneController = TextEditingController();
  String countryCode = "IN";

  Future<bool> _requestPop() {
    Navigator.of(context).pop();

    return Future.value(false);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      setThemePosition(context: context);
      setState(() {});
    });
  }

  TextEditingController textNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            title: const Text(""),
            leading: InkWell(
              onTap: _requestPop,
              child: Icon(
                Icons.keyboard_backspace,
                color: textColor,
              ),
            ),
          ),
          body: Container(
            padding:
                EdgeInsets.symmetric(horizontal: getHorizontalSpace(context)),
            child: ListView(
              children: [
                SizedBox(
                  height: getScreenPercentSize(context, 3),
                ),

                getTextWithFontFamilyWidget(
                  "Forgot Password",
                  textColor,
                  getScreenPercentSize(context, 3),
                  FontWeight.w400,
                  TextAlign.left,
                ),

                SizedBox(
                  height: getScreenPercentSize(context, 0.7),
                ),

                getTextWidget(
                  "We need your registration email to send you password reset code!",
                  textColor,
                  getScreenPercentSize(context, 1.9),
                  FontWeight.w400,
                  TextAlign.left,
                ),

                // getTextWidget(
                //   "Forgot Password",
                //   textColor,
                //   getScreenPercentSize(context, 4),
                //   FontWeight.bold,
                //   TextAlign.left,
                // ),
                // SizedBox(
                //   height: getScreenPercentSize(context, 0.5),
                // ),
                // getTextWidget(
                //   "We need your registration email to send you password reset code!",
                //   subTextColor,
                //   getScreenPercentSize(context, 1.8),
                //   FontWeight.w400,
                //   TextAlign.start,
                // ),
                SizedBox(
                  height: getScreenPercentSize(context, 3),
                ),
                getDefaultTextFiledWidget(context, "Your Email",
                    Icons.account_circle_outlined, textNameController),
                SizedBox(
                  height: getScreenPercentSize(context, 2),
                ),
                getButtonWithoutSpaceWidget(context, "Next", primaryColor, () {
                  sendPage();
                }),
              ],
            ),
          ),
        ));
  }

  void sendPage() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhoneVerification(false),
        ));
  }
}
