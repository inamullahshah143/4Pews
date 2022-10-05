import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:four_pews/adoption_form_page.dart';
import 'package:four_pews/model/product_model.dart';
import 'package:four_pews/utils/constant.dart';
import 'package:four_pews/utils/custom_widget.dart';
import 'package:four_pews/utils/data_file.dart';
import 'package:four_pews/utils/size_config.dart';

import 'location_track_map.dart';

class PetDetailPage extends StatefulWidget {
  final ProductModel model;

  const PetDetailPage({super.key, required this.model});

  @override
  State<PetDetailPage> createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
  List<ProductModel> productList = DataFile.getProductModel();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return Future.value(true);
  }

  void doNothing(BuildContext context) {}

  double defMargin = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    defMargin = getHorizontalSpace(context);

    double imgHeight = getWidthPercentSize(context, 75);
    double margin = getWidthPercentSize(context, 3);

    double height = getScreenPercentSize(context, 7);

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            toolbarHeight: 0,
          ),
          body: Column(
            children: [
              getAppBar(context, widget.model.name!, isBack: true,
                  function: () {
                _requestPop();
              },
                  widget: InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "${assetsPath}heart.png",
                        height: getScreenPercentSize(context, 2.5),
                        color: textColor,
                      ))),
              SizedBox(
                height: getScreenPercentSize(context, 1.5),
              ),
              Expanded(
                flex: 1,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: defMargin),
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(getPercentSize(imgHeight, 4)),
                      child: Image.asset(
                        '${assetsPath}pet_detail.png',
                        // assetsPath + widget.model.image!,
                        width: imgHeight,
                        height: imgHeight,
                        fit: BoxFit.fill,
                      ),
                    ),
                    // SizedBox(height: getScreenPercentSize(context, 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: margin),
                      child: Row(
                        children: [
                          Expanded(
                              child: getTextWithFontFamilyWidget(
                                  widget.model.name!,
                                  textColor,
                                  getScreenPercentSize(context, 3),
                                  FontWeight.w500,
                                  TextAlign.start)),
                          getTextWithFontFamilyWidget(
                              widget.model.price!,
                              primaryColor,
                              getScreenPercentSize(context, 3),
                              FontWeight.w500,
                              TextAlign.start)
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LocationTrackMap(widget.model),
                            ));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            "${assetsPath}location.png",
                            height: getScreenPercentSize(context, 2.2),
                          ),
                          SizedBox(
                            width: getWidthPercentSize(context, 2),
                          ),
                          Expanded(
                              child: getTextWidget(
                                  widget.model.address!,
                                  textColor,
                                  getScreenPercentSize(context, 2),
                                  FontWeight.w400,
                                  TextAlign.start)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getScreenPercentSize(context, 2),
                    ),
                    Row(
                      children: [
                        getCell("Age", "1.5 Years"),
                        SizedBox(
                          width: (margin * 1.5),
                        ),
                        getCell('Gender', 'Female'),
                        SizedBox(
                          width: (margin * 1.5),
                        ),
                        getCell('Weight', '3.5'),
                      ],
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: (margin * 2.5), bottom: margin),
                      child: getTextWithFontFamilyWidget(
                          'Description',
                          textColor,
                          getScreenPercentSize(context, 2),
                          FontWeight.w500,
                          TextAlign.start),
                    ),
                    getCustomTextWidget(
                        loremText,
                        textColor,
                        getScreenPercentSize(context, 1.9),
                        FontWeight.w400,
                        TextAlign.left,
                        3),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: margin),
                child: Row(
                  children: [
                    Container(
                        width: height,
                        height: height,
                        margin: EdgeInsets.only(
                            left: defMargin,
                            bottom: getHorizontalSpace(context),
                            top: getScreenPercentSize(context, 1.2)),
                        decoration: ShapeDecoration(
                          color: backgroundColor,
                          shadows: [
                            BoxShadow(
                                color: primaryColor.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 5,
                                offset: const Offset(0, 5))
                          ],
                          shape: SmoothRectangleBorder(
                            side: BorderSide(color: primaryColor, width: 1.5),
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: getPercentSize(height, 25),
                              cornerSmoothing: 0.8,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            "${assetsPath}call.png",
                            color: primaryColor,
                            height: getPercentSize(height, 45),
                          ),
                        )),
                    // SizedBox(width: margin,),
                    Expanded(
                      flex: 1,
                      child: getButtonWidget(context, "Adopt Now", primaryColor,
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AdoptionFormPage(model: widget.model),
                            ));
                      }),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  getCell(String s, String s1) {
    return Expanded(
      flex: 1,
      child: getMaterialCell(context,
          widget: Container(
            padding: EdgeInsets.symmetric(
                vertical: getScreenPercentSize(context, 2)),
            decoration: getDecorationWithColor(
                getScreenPercentSize(context, 1.3), backgroundColor),
            child: Column(
              children: [
                getTextWidget(
                    s,
                    primaryColor,
                    getScreenPercentSize(context, 1.8),
                    FontWeight.w500,
                    TextAlign.start),
                SizedBox(
                  height: getScreenPercentSize(context, 1),
                ),
                getTextWidget(s1, textColor, getScreenPercentSize(context, 2),
                    FontWeight.w400, TextAlign.start),
              ],
            ),
          )),
    );
  }
}
