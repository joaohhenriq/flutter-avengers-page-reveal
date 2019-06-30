import 'dart:ui';

import 'package:avanger_page_reveal/pages.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final PageIndicatorViewModel viewModel;

  const PageIndicator({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//
            PageBubble(
              viewModel: PageBubbleViewModel(
                  "assets/images/iron-man-icon.png", true, 0.5),
            ),
            PageBubble(
              viewModel: PageBubbleViewModel(
                  "assets/images/captain-america-icon.png", false, 1.0),
            ),
            PageBubble(
              viewModel: PageBubbleViewModel(
                  "assets/images/thor-icon.png", true, 0.5),
            ),
//            Padding(
//              padding: const EdgeInsets.all(10.0),
//              child: Container(
//                width: 20.0,
//                height: 20.0,
//                decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    border: Border.all(color: Color(0x88FFFFFF), width: 3.0)),
//              ),
//            )
          ],
        )
      ],
    );
  }
}

enum SlideDirection { leftToRight, rightToLeft }

class PageIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PageIndicatorViewModel(
      this.pages, this.activeIndex, this.slideDirection, this.slidePercent);
}

class PageBubbleViewModel {
  final String iconAssetPath;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel(this.iconAssetPath, this.isHollow, this.activePercent);
}

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel viewModel;

  const PageBubble({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: lerpDouble(30.0, 70.0, viewModel.activePercent),
        height: lerpDouble(30.0, 70.0, viewModel.activePercent),
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Opacity(
          opacity: viewModel.activePercent,
          child: Image.asset(
            viewModel.iconAssetPath,
          ),
        ),
      ),
    );
  }
}
