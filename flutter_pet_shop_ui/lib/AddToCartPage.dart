import 'package:flutter/material.dart';

class AddToCartPage extends StatefulWidget {
  final Function? function;

  AddToCartPage({this.function});

  @override
  _AddToCartPage createState() {
    return _AddToCartPage();
  }
}

class _AddToCartPage extends State<AddToCartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Coming Soon'),
      ),
    );
  }
}
