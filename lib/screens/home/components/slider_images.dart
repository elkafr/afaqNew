import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afaq/components/carousel_slider/carousel_with_indicator.dart';
import 'package:afaq/models/slider.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/utils/utils.dart';

class SliderImages extends StatefulWidget {
  @override
  _SliderImagesState createState() => _SliderImagesState();
}

class _SliderImagesState extends State<SliderImages> {

  Services _services = Services();
  bool _initialRun = true;

  Future<List<SliderModel>>? _sliderImages;

  Future<List<SliderModel>> _getsliderImages() async {
    Map<dynamic, dynamic> results = await _services.get(Utils.SLIDER_URL);
    List sliderList = <SliderModel>[];
    if (results['response'] == '1') {
      Iterable iterable = results['slider'];
      sliderList = iterable
          .map((model) => SliderModel.fromJson(model))
          .toList();
    } else {
      print('error');
    }
    return sliderList as FutureOr<List<SliderModel>>;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    // _controller = PageController(initialPage: _currentPageValue);
  }

  @override
  void didChangeDependencies() {
    if (_initialRun) {
      _sliderImages = _getsliderImages();
      _initialRun = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SliderModel>>(
      future: _sliderImages,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CarouselWithIndicator(imgList: snapshot.data!);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SpinKitSquareCircle(color: cPrimaryColor, size: 25),
          ),
        );
      },
    );
  }

  // void getChangedPageAndMoveBar(int page) {
  //   print('page is $page');

  //   _currentPageValue = page;

  //   if (_previousPageValue == 0) {
  //     _previousPageValue = _currentPageValue;
  //   } else {
  //     if (_previousPageValue < _currentPageValue) {
  //       _previousPageValue = _currentPageValue;
  //     } else {
  //       _previousPageValue = _currentPageValue;
  //     }
  //   }

  //   setState(() {});
  // }
}
