import 'package:flutter/material.dart';
import 'package:four_pews/utils/constant.dart';
import 'package:four_pews/utils/custom_widget.dart';
import 'package:four_pews/utils/size_config.dart';

import 'generated/l10n.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  TextEditingController cardNumberController = TextEditingController();

  TextEditingController cardHolderNameController = TextEditingController();

  TextEditingController expDateController = TextEditingController();

  TextEditingController cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = getHorizontalSpace(context);

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            toolbarHeight: 0,
            backgroundColor: backgroundColor,
            title: getAppBarText(context, 'New Card'),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
          ),
          body: Column(
            children: [
              getAppBar(context, 'Add New Card', isBack: true, function: () {
                _requestPop();
              }),
              Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.all(leftMargin),
                      child: Column(
                        children: [
                          getDefaultTextFiledWithoutIconWidget(context,
                              S.of(context).cardNumber, cardNumberController),
                          getDefaultTextFiledWithoutIconWidget(
                              context,
                              S.of(context).cardHolderName,
                              cardHolderNameController),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: getDefaultTextFiledWithoutIconWidget(
                                    context,
                                    S.of(context).expDateHint,
                                    expDateController),
                              ),
                              SizedBox(
                                width: getScreenPercentSize(context, 1),
                              ),
                              Expanded(
                                flex: 1,
                                child: getDefaultTextFiledWithoutIconWidget(
                                    context,
                                    S.of(context).cvvHint,
                                    cvvController),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: getScreenPercentSize(context, 0.5)),
                child: getButtonWidget(context, "Save", primaryColor, () {
                  Navigator.of(context).pop();
                }),
              )
            ],
          ),
        ));
  }
}
