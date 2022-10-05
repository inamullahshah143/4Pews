import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:four_pews/add_to_cart_page.dart';
import 'package:four_pews/tab_widget/chat_boot.dart';
import 'package:four_pews/tab_widget/home_widget.dart';

import 'package:four_pews/tab_widget/search_widget.dart';
import 'package:four_pews/utils/constant.dart';
import 'package:four_pews/utils/custom_widget.dart';

import 'all_pet_page.dart';
import 'customView/custom_animated_bottom_bar.dart';

class MainPage extends StatefulWidget {
  final int? tabPosition;
  MainPage({this.tabPosition});

  @override
  _MainPage createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  int _currentIndex = 0;

  Future<bool> _requestPop() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex = 0;
      });
    } else {
      exitApp();
    }
    return new Future.value(false);
  }

  Widget getBody() {
    List<Widget> pages = [
      HomeWidget(() {
        setState(() {
          _currentIndex = 3;
        });
      }, functionViewAll: () {
        setState(() {
          _currentIndex = 1;
        });
      }, functionAdoptionAll: () {
        setState(() {
          _currentIndex = 3;
        });
      }),
      SearchWidget(),
      AddToCartPage(function: () {
        _requestPop();
      }),
      AllPetPage(function: () {
        _requestPop();
      }),
      ChatBoot(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.tabPosition != null) {
      setState(() {
        _currentIndex = widget.tabPosition!;
      });
    }
    Future.delayed(Duration(seconds: 0), () {
      setThemePosition(context: context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: backgroundColor,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: backgroundColor,
              statusBarIconBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
          ),
          resizeToAvoidBottomInset: true,
          backgroundColor: backgroundColor,
          bottomNavigationBar: _buildBottomBar(),
          body: SafeArea(
            child: Container(child: getBody()),
          ),
        ),
        onWillPop: _requestPop);
  }

  Widget _buildBottomBar() {
    final _inactiveColor = iconColor;
    final _activeColor = primaryColor;

    double height = getScreenPercentSize(context, 7.5);
    double iconHeight = getPercentSize(height, 28);
    return CustomAnimatedBottomBar(
      containerHeight: height,
      backgroundColor: backgroundColor,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          title: 'Home',
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          imageName: "home bold.png",
        ),
        BottomNavyBarItem(
          title: 'Search',
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          imageName: "search.png",
        ),
        BottomNavyBarItem(
          title: 'Cart',
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          imageName: "orders.png",
        ),
        BottomNavyBarItem(
          title: 'All Pets',
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          imageName: "pet.png",
        ),
        BottomNavyBarItem(
            iconSize: iconHeight,
            title: 'Chat',
            activeColor: _activeColor,
            imageName: "chat.png",
            inactiveColor: _inactiveColor,
            textAlign: TextAlign.center),
      ],
    );
  }
}
