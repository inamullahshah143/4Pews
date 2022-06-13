import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  final Function function;
  ProfileWidget(this.function);

  @override
  _ProfileWidget createState() {
    return _ProfileWidget();
  }
}

class _ProfileWidget extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Coming Soon'),
      ),
    );
  }
}
