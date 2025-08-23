import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:afaq/models/category.dart';
import 'package:afaq/utils/app_colors.dart';

class CategoryItem1 extends StatelessWidget {
  final Category? category;
  final AnimationController? animationController;
  final Animation? animation;

  const CategoryItem1({
    Key? key,
    this.category,
    this.animationController,
    this.animation,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: constraints.maxHeight * 0.05),

                width: constraints.maxWidth * 0.95,
                height: constraints.maxHeight * 0.95,
                padding: EdgeInsets.only(top: 5, bottom: 5, right: 7),
                decoration: BoxDecoration(
                  color: Color(0xffF3F3F3),
                  /*border: Border.all(
                  width: 1.0,
                  color: category.isSelected ? cPrimaryColor: Color(0xffF3F3F3),
                ),*/
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -10,
                      left: -10,
                      child: Image.network(category!.mtgerCatPhoto!),
                    ),

                    Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(bottom: 10),
                      width: constraints.maxWidth * .60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            category!.mtgerCatName!,
                            style: TextStyle(
                              color: cText,
                              fontSize: category!.mtgerCatName!.length > 1
                                  ? 15
                                  : 15,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Padding(padding: EdgeInsets.all(3)),
                          Text(
                            category!.mtgerCatDetails!,
                            style: TextStyle(
                              color: cHintColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
