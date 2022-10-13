import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:four_pews/utils/constant.dart';
import 'package:four_pews/utils/custom_dialog_box.dart';
import 'package:four_pews/utils/custom_widget.dart';
import 'package:four_pews/utils/size_config.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'reset_password_page.dart';
import 'sign_in_page.dart';

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
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;
  String? verificationCode;

  @override
  initState() {
    _verifyPhone();
    setThemePosition(context: context);
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    super.initState();
  }

  void resendCode() {
    _verifyPhone();
    setState(() {
      secondsRemaining = 60;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {}
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message.toString()),
            ),
          );
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }

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
                          _verifyPhone();
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
                        if (widget.isSignUp) {
                            
                          await FirebaseFirestore.instance
                              .collection('user')
                              .doc(widget.result.user.uid)
                              .set({
                            // 'username': fullName.text,
                            // 'email': email.text,
                            'phone_no': widget.phoneNo,
                          }).whenComplete(() {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Account Created!",
                                  descriptions:
                                      "Your account has\nbeen successfully created!",
                                  text: "Continue",
                                  func: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignInPage(),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          });
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPasswordPage(),
                            ),
                          );
                        }
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
