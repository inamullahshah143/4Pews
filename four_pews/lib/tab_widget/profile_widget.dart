import 'package:flutter/material.dart';
import 'package:four_pews/generated/l10n.dart';
import 'package:four_pews/model/profile_model.dart';
import 'package:four_pews/utils/constant.dart';
import 'package:four_pews/utils/custom_widget.dart';
import 'package:four_pews/utils/data_file.dart';
import 'package:four_pews/utils/pref_data.dart';
import 'package:four_pews/utils/size_config.dart';

import '../about_us_page.dart';
import '../add_to_cart_page.dart';
import '../auth/sign_in_page.dart';
import '../my_adoption_page.dart';
import '../my_order_page.dart';
import '../my_saved_cards_page.dart';
import '../notification_list.dart';
import '../profile_page.dart';
import '../shipping_address_page.dart';
import '../write_review_page.dart';

class ProfileWidget extends StatefulWidget {
  final Function function;
  const ProfileWidget(this.function);

  @override
  _ProfileWidget createState() {
    return _ProfileWidget();
  }
}

class _ProfileWidget extends State<ProfileWidget>
    with SingleTickerProviderStateMixin {
  double padding = 0;
  double defMargin = 0;
  double height = 0;

  ProfileModel profileModel = DataFile.getProfileModel();

  @override
  void initState() {
    super.initState();
    getThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    padding = getScreenPercentSize(context, 2);
    defMargin = getHorizontalSpace(context);
    height = getScreenPercentSize(context, 5.5);

    Container divider = Container(
      margin: EdgeInsets.symmetric(
          vertical: (defMargin / 1.5), horizontal: defMargin),
      height: getScreenPercentSize(context, 0.03),
      color: primaryColor.withOpacity(0.7),
    );

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: backgroundColor,
          // padding: EdgeInsets.symmetric(horizontal:  defMargin),
          child: Column(
            children: [
              getAppBar(context, "More"),
              SizedBox(
                height: getScreenPercentSize(context, 1.5),
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    SizedBox(
                      height: getScreenPercentSize(context, 1.5),
                    ),

                    InkWell(
                      child: _getCell(S.of(context).editProfiles, Icons.edit),
                      onTap: () {
                        sendAction(ProfilePage());
                      },
                    ),
                    divider,
                    InkWell(
                      child: _getCell('My Order', Icons.shopping_bag),
                      onTap: () {
                        sendAction(MyOrderPage(false));
                      },
                    ),
                    divider,
                    InkWell(
                      child: _getCell('Cart', Icons.shopping_cart),
                      onTap: () {
                        sendAction(AddToCartPage());
                      },
                    ),
                    divider,
                    InkWell(
                      child: _getCell(
                          S.of(context).address, Icons.local_shipping_outlined),
                      onTap: () {
                        sendAction(ShippingAddressPage());
                      },
                    ),
                    divider,
                    InkWell(
                      child: _getCell(
                          S.of(context).mySavedCards, Icons.credit_card),
                      onTap: () {
                        sendAction(MySavedCardsPage());
                      },
                    ),
                    divider,

                    InkWell(
                      child: _getCell('My Adoption', Icons.credit_card,
                          image: "pet.png"),
                      onTap: () {
                        sendAction(MyAdoptionPage());
                      },
                    ),
                    divider,

                    InkWell(
                      child: _getCell('Notification', Icons.notifications_none),
                      onTap: () {
                        sendAction(NotificationList());
                      },
                    ),
                    divider,
                    InkWell(
                      child: _getCell(S.of(context).review, Icons.rate_review),
                      onTap: () {
                        sendAction(WriteReviewPage());
                      },
                    ),
                    divider,
                    InkWell(
                      child: _getCell(S.of(context).aboutUs, Icons.info),
                      onTap: () {
                        sendAction(AboutUsPage());
                      },
                    ),

                    SizedBox(
                      height: getScreenPercentSize(context, 2),
                    ),
                    getButtonWidget(context, S.of(context).logout, primaryColor,
                        () {
                      PrefData.setIsSignIn(false);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ));
                    }),
                    // InkWell(
                    //   child: _getCell(S.of(context).logout, Icons.logout),
                    //   onTap: () {
                    //     PrefData.setIsSignIn(false);
                    //
                    //
                    //
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool themMode = false;

  void sendAction(StatefulWidget className) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => className));
  }

  getThemeMode() async {
    themMode = await PrefData.getNightTheme();
    setState(() {});
  }

  Widget _getCell(String s, var icon, {String? image}) {
    double size = getScreenPercentSize(context, 6);
    double iconSize = getPercentSize(size, 50);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: defMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: getScreenPercentSize(context, 1)),
            height: size,
            width: size,
            decoration: BoxDecoration(
                color: alphaColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(getPercentSize(size, 15)))),
            child: (image != null)
                ? Center(
                    child: Image.asset(
                      assetsPath + image,
                      height: iconSize,
                      color: primaryColor,
                    ),
                  )
                : Icon(
                    icon,
                    size: iconSize,
                    color: primaryColor,
                  ),
          ),
          Text(
            s,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: getScreenPercentSize(context, 2),
              fontFamily: fontFamily,
              color: textColor,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                "${assetsPath}right-chevron.png",
                color: textColor,
                height: getScreenPercentSize(context, 2),
              ),
            ),
          )
        ],
      ),
    );
  }
}
