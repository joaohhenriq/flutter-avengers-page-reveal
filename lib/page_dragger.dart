import 'dart:async';
import 'dart:ui';

import 'package:avanger_page_reveal/pager_indicator.dart';
import 'package:flutter/material.dart';

class PageDragger extends StatefulWidget {
  final bool canDragLeftToRight;
  final bool canDragRightToLeft;

  final StreamController<SlideUpdate> slideUpdateStream;

  PageDragger(
      {this.slideUpdateStream,
      this.canDragLeftToRight,
      this.canDragRightToLeft});

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
      if (dx > 0.0 && widget.canDragRightToLeft) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0.0 && widget.canDragLeftToRight) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }

      // clamp não deixa os valores passar de 0 e 1, no caso
      // precisa disso se por exemplo o usuário arrastar a tela para um valor
      // que ultrapassa 0 e 1
      // abs pega o valor absoluto, não deixa pegar negativo
      if (slideDirection != SlideDirection.none) {
        slidePercent = (dx / FULL_TRANSITION_PX).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }

      widget.slideUpdateStream.add(
          new SlideUpdate(slideDirection, slidePercent, UpdateType.dragging));
    }
  }

  onDragEnd(DragEndDetails details) {
    widget.slideUpdateStream.add(
        new SlideUpdate(SlideDirection.none, 0.0, UpdateType.doneDragging));
    dragStart = null;
  }
}

class AnimatedPageDragger {
  static const PERCENT_PER_MILLISECOND = 0.005;
  final slideDirection;
  final transitionGoal;

  AnimationController completionAnimationController;

  AnimatedPageDragger(
      {this.slideDirection,
      this.transitionGoal,
      slidePercent,
      StreamController<SlideUpdate> slideUpdateStream,
      TickerProvider vsync}) {
    final startSlidePercent = slidePercent;
    var endSlidePercent;
    var duration;

    if (transitionGoal == TransitionGoal.open) {
      endSlidePercent = 1.0;
      final slideRemaining = 1.0 - slidePercent;
      duration = new Duration(
          milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round());
    } else {
      endSlidePercent = 0.0;
      duration = new Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round());
    }

    completionAnimationController = AnimationController(
        vsync: vsync, duration: duration)
      ..addListener(() {
        slidePercent = lerpDouble(startSlidePercent, endSlidePercent,
            completionAnimationController.value);

        slideUpdateStream.add(
            SlideUpdate(slideDirection, slidePercent, UpdateType.animating));
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          slideUpdateStream.add(SlideUpdate(
              slideDirection, endSlidePercent, UpdateType.doneAnimating));
        }
      });
  }

  run(){
    completionAnimationController.forward(from: 0.0);
  }

  dispose(){
    completionAnimationController.dispose();
  }
}

enum TransitionGoal {
  open,
  close,
}

enum UpdateType { dragging, doneDragging, animating, doneAnimating }

class SlideUpdate {
  final direction;
  final slidePercent;
  final updateType;

  SlideUpdate(this.direction, this.slidePercent, this.updateType);
}
