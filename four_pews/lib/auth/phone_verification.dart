import 'dart:async';

import 'package:flutter/material.dart';
import 'package:four_pews/utils/constant.dart';
import 'package:four_pews/utils/custom_widget.dart';
import 'package:four_pews/utils/size_config.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class PhoneVerification extends StatefulWidget {
  final bool isSignUp;
  final dynamic result;
  final String phoneNo;
  const PhoneVerification({
    super.key,
    required this.isSignUp,
    this.result,
    required this.phoneNo,
  });
  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
//
 

//
  bool isRemember = false;

  int themeMode = 0;

  TextEditingController textEmailController = TextEditingController();

  TextEditingController textPasswordController = TextEditingController();

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return Future.value(true);
  }

  final GlobalKey<FormFieldState<String>> _formKey =
      GlobalKey<FormFieldState<String>>(debugLabel: '_formKey');

  final TextEditingController _pinEditingController = TextEditingController();

  final bool _enable = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ColorBuilder solidColor = PinListenColorBuilder(cellColor, cellColor);

    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: const Text(""),
          leading: GestureDetector(
            onTap: () {
              _requestPop();
            },
            child: Icon(
              Icons.keyboard_backspace,
              color: textColor,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(getHorizontalSpace(context)),
            child: ListView(
              children: [
                SizedBox(
                  height: getScreenPercentSize(context, 3),
                ),
                getTextWithFontFamilyWidget(
                  "Verify",
                  textColor,
                  getScreenPercentSize(context, 3),
                  FontWeight.w400,
                  TextAlign.left,
                ),
                SizedBox(
                  height: getScreenPercentSize(context, 0.7),
                ),
                getTextWidget(
                  "Enter code send to your mobile number",
                  textColor,
                  getScreenPercentSize(context, 1.9),
                  FontWeight.w400,
                  TextAlign.left,
                ),
                SizedBox(
                  height: getScreenPercentSize(context, 5),
                ),
                Center(
                  child: SizedBox(
                    width: SizeConfig.safeBlockHorizontal! * 70,
                    child: PinInputTextFormField(
                      key: _formKey,
                      pinLength: 4,
                      decoration: BoxLooseDecoration(
                        bgColorBuilder: solidColor,
                        strokeWidth: 0.5,
                        textStyle: TextStyle(
                            color: textColor,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        strokeColorBuilder: PinListenColorBuilder(
                          subTextColor,
                          subTextColor,
                        ),
                        obscureStyle: ObscureStyle(
                          isTextObscure: false,
                          obscureText: '🤪',
                        ),
                      ),
                      controller: _pinEditingController,
                      textInputAction: TextInputAction.go,
                      enabled: _enable,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      onSubmit: (pin) {
                        if (_formKey.currentState!.validate()) {
                        
                        }
                      },
                      onChanged: (pin) {
                        setState(() {
                          debugPrint('onChanged execute. pin:$pin');
                        });
                      },
                      onSaved: (pin) {
                        debugPrint('onSaved pin:$pin');
                      },
                      validator: (pin) {
                        if (pin!.isEmpty) {
                          setState(() {});
                          return 'Pin cannot empty.';
                        }
                        setState(() {});
                        return null;
                      },
                      cursor: Cursor(
                        width: 2,
                        color: primaryColor,
                        radius: const Radius.circular(1),
                        enabled: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 5,
                ),
                Column(
                  children: [
                    getButtonWithoutSpaceWidget(
                      context,
                      "Next",
                      primaryColor,
                      () async {
                        if (widget.isSignUp) {}
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 3,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: getScreenPercentSize(context, 2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getTextWidget(
                              "Didn't receive code?",
                              textColor,
                              getScreenPercentSize(context, 2),
                              FontWeight.w600,
                              TextAlign.center,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              child: getTextWidget(
                                "Resend",
                                primaryColor,
                                getScreenPercentSize(context, 2),
                                FontWeight.w700,
                                TextAlign.center,
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
