import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet_shop/model/DataModel.dart';
import 'package:flutter_pet_shop/model/ProductModel.dart';
import 'package:flutter_pet_shop/utils/Constant.dart';
import 'package:flutter_pet_shop/utils/CustomWidget.dart';
import 'package:flutter_pet_shop/utils/DataFile.dart';
import 'package:flutter_pet_shop/utils/SizeConfig.dart';

import '../ProductDetailPage.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidget createState() {
    return _SearchWidget();
  }
}

class _SearchWidget extends State<SearchWidget>
    with SingleTickerProviderStateMixin {
  double padding = 0;
  double defMargin = 0;
  double height = 0;

  List<DataModel> dataList = DataFile.getCategoryData();
  List<ProductModel> productList = DataFile.getProductModel();

  @override
  void initState() {
    super.initState();
  }

  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    padding = getScreenPercentSize(context, 2);
    defMargin = getHorizontalSpace(context);
    height = getScreenPercentSize(context, 5.5);

    double radius = getScreenPercentSize(context, 1.5);
    print("defMargin-12--$defMargin");
    return Container(
      width: double.infinity,
      color: backgroundColor,
      // padding: EdgeInsets.on(vertical: defMargin),
      child: GestureDetector(
        onTap: () {
          setState(() {
            myFocusNode.canRequestFocus = false;
          });
        },
        child: Column(
          children: [
            getAppBar(context, "Search"),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: getScreenPercentSize(context, 1.5),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defMargin),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return Container(
                          decoration: getDecorationWithBorder(radius,
                              color: isAutoFocus ? primaryColor : borderColor),
                          child: Focus(
                            onFocusChange: (hasFocus) {
                              if (hasFocus) {
                                setState(() {
                                  isAutoFocus = true;
                                });
                              } else {
                                setState(() {
                                  isAutoFocus = false;
                                });
                              }
                            },
                            child: TextField(
                              focusNode: myFocusNode,
                              autofocus: false,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                color: textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: getScreenPercentSize(context, 1.7),
                              ),
                              onChanged: (string) {},
                              maxLines: 1,
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: defMargin),
                                hintText: 'Search food , accessories..',
                                // prefixIcon: Icon(Icons.search),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: subTextColor,
                                ),
                                hintStyle: TextStyle(
                                  color: subTextColor,
                                  fontFamily: fontFamily,
                                  fontSize: getScreenPercentSize(context, 1.7),
                                  fontWeight: FontWeight.w400,
                                ),
                                filled: true,
                                isDense: true,
                                fillColor: Colors.transparent,
                                disabledBorder: getOutLineBorder(radius),
                                enabledBorder: getOutLineBorder(radius),
                                focusedBorder: getOutLineBorder(radius),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: (defMargin / 2),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defMargin),
                    child: getTextWithFontFamilyWidget(
                        'Category',
                        textColor,
                        getScreenPercentSize(context, 2),
                        FontWeight.w500,
                        TextAlign.start),
                  ),
                  SizedBox(
                    height: (defMargin / 2),
                  ),
                  getCategoryList(),
                  sellerList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int selectedCategory = 0;

  sellerList() {
    defMargin = getScreenPercentSize(context, 1.5);

    var height = getScreenPercentSize(context, 35);

    double width = getWidthPercentSize(context, 40);

    double imgHeight = getPercentSize(height, 45);
    double remainHeight = height - imgHeight;

    double radius = getPercentSize(height, 5);

    double _crossAxisSpacing = 0;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    var _aspectRatio = _width / height;

    return GridView.count(
      crossAxisCount: _crossAxisCount,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: (defMargin * 1.2)),
      scrollDirection: Axis.vertical,
      primary: false,
      crossAxisSpacing: (defMargin * 2),
      mainAxisSpacing: 0,
      childAspectRatio: _aspectRatio,
      children: List.generate(productList.length, (index) {
        ProductModel model = productList[index];

        return InkWell(
          child: Container(
            width: width,
            margin: EdgeInsets.only(top: defMargin, bottom: (defMargin)),
            decoration: ShapeDecoration(
              color: backgroundColor,
              shadows: [
                BoxShadow(
                    color: subTextColor.withOpacity(0.1),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(0, 1))
              ],
              shape: SmoothRectangleBorder(
                // side: BorderSide(color: iconColor, width: 0.1),
                borderRadius: SmoothBorderRadius(
                  cornerRadius: radius,
                  cornerSmoothing: 0.8,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: imgHeight,
                  // color: Colors.red,
                  margin: EdgeInsets.only(
                      top: getPercentSize(width, 7),
                      bottom: getPercentSize(width, 5)),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          assetsPath + model.icon!,
                          height: getPercentSize(imgHeight, 75),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: getPercentSize(imgHeight, 9),
                          ),
                          height: getPercentSize(imgHeight, 18),
                          width: getPercentSize(imgHeight, 18),
                          child: Center(
                            child: Image.asset(assetsPath + "heart.png",
                                color: primaryColor,
                                height: getPercentSize(imgHeight, 20)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getPercentSize(width, 5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: getCustomTextWidget(
                                  model.subText!,
                                  textColor,
                                  getPercentSize(remainHeight, 8),
                                  FontWeight.bold,
                                  TextAlign.start,
                                  1)),
                        ],
                      ),
                      // SizedBox(
                      //   height: getPercentSize(remainHeight, 4),
                      // ),
                      SizedBox(
                        height: getPercentSize(remainHeight, 5),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            assetsPath + "star.png",
                            height: getPercentSize(remainHeight, 9),
                          ),
                          SizedBox(
                            width: getPercentSize(width, 2),
                          ),
                          getTextWidget(
                              '4.5',
                              subTextColor,
                              getPercentSize(remainHeight, 8),
                              FontWeight.w400,
                              TextAlign.start),
                          SizedBox(
                            width: getPercentSize(width, 4.5),
                          ),
                          Expanded(
                            child: getTextWidget(
                                '19 Reviews',
                                subTextColor,
                                getPercentSize(remainHeight, 8),
                                FontWeight.w400,
                                TextAlign.start),
                          )
                        ],
                      ),
                      SizedBox(
                        height: getPercentSize(remainHeight, 5),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: getTextWithFontFamilyWidget(
                                  model.price!,
                                  primaryColor,
                                  getPercentSize(remainHeight, 12),
                                  FontWeight.w400,
                                  TextAlign.start)),
                          SizedBox(
                            width: getPercentSize(width, 2),
                          ),
                          getAddMaterialWidget(
                              context,
                              Container(
                                height: getPercentSize(remainHeight, 15),
                                width: getPercentSize(remainHeight, 15),
                                decoration: getDecorationWithColor(
                                    getPercentSize(remainHeight, 3),
                                    primaryColor),
                                child: Center(
                                  child: Icon(Icons.add,
                                      color: Colors.white,
                                      size: getPercentSize(remainHeight, 15)),
                                ),
                              ),
                              getPercentSize(remainHeight, 3),
                              getPercentSize(remainHeight, 16))
                        ],
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(model)));
          },
        );
      }),
    );
  }

  getCategoryList() {
    double height = getScreenPercentSize(context, 7);
    double width = getWidthPercentSize(context, 30);
    return Container(
        height: height,
        margin: EdgeInsets.symmetric(vertical: padding),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: dataList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Color color = "#F1DDD3".toColor();

              if (index % 3 == 0) {
                color = "#F7E1BD".toColor();
              } else if (index % 3 == 1) {
                color = "#DBF0E5".toColor();
              } else if (index % 3 == 2) {
                color = "#F1DDD3".toColor();
              }
              return InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: selectedCategory == index
                              ? primaryColor
                              : Colors.transparent,
                          width: selectedCategory == index ? 1 : 0),
                      borderRadius: BorderRadius.all(
                          Radius.circular(getPercentSize(height, 50)))),
                  margin: EdgeInsets.only(
                      left: index == 0 ? (defMargin) : (defMargin / 1.5)),
                  child: Container(
                    margin: EdgeInsets.all(1),
                    width: width,
                    decoration: ShapeDecoration(
                      color: color,
                      shape: SmoothRectangleBorder(
                        // side: BorderSide(color: primaryColor,width: selectedCategory==index?1:0),

                        borderRadius: SmoothBorderRadius(
                          cornerRadius: getPercentSize(height, 50),
                          cornerSmoothing: 0.8,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: height,
                          width: height,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              assetsPath + dataList[index].image!,
                              height: getPercentSize(height, 60),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getPercentSize(width, 10),
                        ),
                        Expanded(
                            child: getCustomTextWidget(
                                dataList[index].name!,
                                Colors.black,
                                getPercentSize(width - height, 22),
                                FontWeight.w500,
                                TextAlign.start,
                                1))
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedCategory = index;
                  });
                },
              );
            }));
  }
}
