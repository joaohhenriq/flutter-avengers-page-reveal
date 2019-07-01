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
      bubbles.add(PageBubble(
        viewModel: PageBubbleViewModel(page.iconAssetPath,
            i > viewModel.activeIndex, i == viewModel.activeIndex ? 1.0 : 0.0),
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
            color: viewModel.isHollow ? Colors.transparent : Color(0x88FFFFFF),
            border: Border.all(
                color:
                    viewModel.isHollow ? Color(0x88FFFFFF) : Colors.transparent,
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
