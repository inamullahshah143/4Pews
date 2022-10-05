import 'package:flutter/material.dart';
import 'package:four_pews/utils/constant.dart';
import 'package:four_pews/utils/custom_widget.dart';
import 'package:four_pews/utils/reset_password_dialog_box.dart';
import 'package:four_pews/utils/size_config.dart';
import 'sign_in_page.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPage createState() {
    return _ResetPasswordPage();
  }
}

class _ResetPasswordPage extends State<ResetPasswordPage> {
  TextEditingController textPasswordController = TextEditingController();
  TextEditingController textConfirmPasswordController = TextEditingController();

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
                  "Create Password",
                  textColor,
                  getScreenPercentSize(context, 3),
                  FontWeight.w400,
                  TextAlign.left,
                ),

                SizedBox(
                  height: getScreenPercentSize(context, 0.7),
                ),

                getTextWidget(
                  "Enter a new password",
                  textColor,
                  getScreenPercentSize(context, 1.9),
                  FontWeight.w400,
                  TextAlign.left,
                ),

                // getTextWidget(
                //       "Create Password",
                //   textColor,
                //   getScreenPercentSize(context, 4.2),
                //
                //     FontWeight.bold,
                //     TextAlign.left,
                //     ),
                //
                //
                // SizedBox(
                //   height: getScreenPercentSize(context, 0.5),
                // ),
                //
                // getTextWidget(
                //     "Enter a new password",
                //    subTextColor,
                //   getScreenPercentSize(context, 1.8),
                //     FontWeight.w400,
                //     TextAlign.start,
                //     ),

                SizedBox(
                  height: getScreenPercentSize(context, 2.5),
                ),
                getPasswordTextFiled(
                    context, "Old password", textPasswordController),
                getPasswordTextFiled(
                    context, "New password", textPasswordController),
                getPasswordTextFiled(
                    context, "Confirm Password", textConfirmPasswordController),
                SizedBox(
                  height: getScreenPercentSize(context, 1.5),
                ),
                getButtonWithoutSpaceWidget(context, "Next", primaryColor, () {
                  checkValidation();
                }),
              ],
            ),
          ),
        ));
  }

  void checkValidation() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ResetPasswordDialogBox(
            func: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ));
            },
          );
        });
  }

  checkNetwork() async {}
}
