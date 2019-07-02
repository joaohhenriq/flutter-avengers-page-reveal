import 'package:avanger_page_reveal/pager_indicator.dart';
import 'package:flutter/material.dart';

class PageDragger extends StatefulWidget {
  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  static const FULL_TRANSITION_PX = 300.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
    );
  }

  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent = 0.0;

  onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      final newPosition = details.globalPosition;
      final dx = dragStart.dx - newPosition.dx;
      if (dx > 0.0) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0.0) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }

      // clamp não deixa os valores passar de 0 e 1, no caso
      // precisa disso se por exemplo o usuário arrastar a tela para um valor
      // que ultrapassa 0 e 1
      // abs pega o valor absoluto, não deixa pegar negativo
      slidePercent = (dx / FULL_TRANSITION_PX).abs().clamp(0.0, 1.0);

      print('Dragging $slideDirection at $slidePercent%');
    }
  }

  onDragEnd(DragEndDetails details) {
    dragStart = null;
  }
}
