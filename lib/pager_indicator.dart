import 'dart:ui';

import 'package:avanger_page_reveal/pages.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final PageIndicatorViewModel viewModel;

  const PageIndicator({this.viewModel});

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];
    for (var i = 0; i < viewModel.pages.length; i++) {
      final page = viewModel.pages[i];

      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i > viewModel.activeIndex ||
          (i == viewModel.activeIndex &&
              viewModel.slideDirection == SlideDirection.leftToRight);

      bubbles.add(PageBubble(
        viewModel:
            PageBubbleViewModel(page.iconAssetPath, isHollow, percentActive),
      ));
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bubbles,
        )
      ],
    );
  }
}

enum SlideDirection { leftToRight, rightToLeft, none }

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
        width: lerpDouble(20.0, 70.0, viewModel.activePercent),
        height: lerpDouble(20.0, 70.0, viewModel.activePercent),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: viewModel.isHollow
                ? Color(0x88FFFFFFF)
                    .withAlpha((0x88 * viewModel.activePercent).round())
                : Color(0x88FFFFFF),
            border: Border.all(
                color: viewModel.isHollow
                    ? Color(0x88FFFFFFF).withAlpha(
                        (0x88 * (1 - viewModel.activePercent)).round())
                    : Colors.transparent,
                width: 3.0)),
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
