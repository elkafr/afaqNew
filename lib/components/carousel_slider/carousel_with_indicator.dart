import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:afaq/models/slider.dart';
import 'package:afaq/utils/app_colors.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  final List<SliderModel>? imgList;

  const CarouselWithIndicator({@required this.imgList});
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 184,
            autoPlay: true,
            onPageChanged: (int index, CarouselPageChangedReason changeReason) {
              setState(() {
                _current = index;
              });
            },
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            aspectRatio: MediaQuery.of(context).size.aspectRatio,
          ),
          items: map<Widget>(widget.imgList!, (index, i) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.network(
                i.photo,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            );
          }).toList(),
        ),

        Positioned(
          bottom: 5,
          left: MediaQuery.of(context).size.width * 0.45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(widget.imgList!, (index, url) {
              // return   Container(
              //   alignment: Alignment.center,
              //                   margin: EdgeInsets.only(top: 5),
              //                   child: DotsIndicator(
              //                     dotsCount: widget.imgList.length,
              //                     position: _current.toDouble(),
              //                     decorator: DotsDecorator(
              //                       size: const Size(24.0, 5.0),
              //                       shape: RoundedRectangleBorder(
              //                           borderRadius:
              //                               BorderRadius.circular(3.0)),
              //                       activeSize: const Size(24.0, 5.0),
              //                       activeColor: cAccentColor,
              //                       color: Color(0xffEEEEEE),
              //                       activeShape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(3.0),
              //                       ),
              //                     ),
              //                   ));
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? cPrimaryColor : cWhite,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
