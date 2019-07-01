import 'package:flutter/material.dart';

final pages = [
  PageViewModel(
      "assets/images/iron-man.jpg", "assets/images/iron-man-icon.png"),
  PageViewModel("assets/images/captain-america.jpg",
      "assets/images/captain-america-icon.png"),
  PageViewModel("assets/images/thor.jpg", "assets/images/thor-icon.png")
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;

  Page({this.viewModel, this.percentVisible = 1.0});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(viewModel.imageAssetPath), fit: BoxFit.cover)),
      child: Opacity(
        opacity: percentVisible,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Transform(
              transform: Matrix4.translationValues(0.0, 50.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  "TESTE",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: Text(
                "TESTE",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PageViewModel {
  final String imageAssetPath;
  final String iconAssetPath;

  PageViewModel(this.imageAssetPath, this.iconAssetPath);
}
