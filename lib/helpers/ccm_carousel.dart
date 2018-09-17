import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';

class CCMCarousel extends StatefulWidget {
  //All the images on this Carousel.
  final List<Widget> images;

  //The transition animation timing curve. Default is [Curves.ease]
  final Curve animationCurve;

  //The transition animation duration. Default is 300ms.
  final Duration animationDuration;

  // The base size of the dots. Default is 8.0
  final double dotSize;

  // The increase in the size of the selected dot. Default is 2.0
  final double dotIncreaseSize;

  // The distance between the center of each dot. Default is 25.0
  final double dotSpacing;

  // The Color of each dot. Default is Colors.white
  final Color dotColor;

  // The background Color of the dots. Default is [Colors.grey[800].withOpacity(0.5)]
  final Color dotBgColor;

  // Enable or Disable the indicator (dots). Default is true
  final bool showIndicator;

  //Padding Size of the background Indicator. Default is 20.0
  final double indicatorBgPadding;

  //How to show the images in the box. Default is cover
  final BoxFit boxFit;

  //Enable/Disable radius Border for the images. Default is false
  final bool borderRadius;

  //Border Radius of the images. Default is [Radius.circular(8.0)]
  final Radius radius;

  //Move the Indicator From the Bottom
  final double moveIndicatorFromBottom;

  //Remove the radius bottom from the indicator background. Default false
  final bool noRadiusForIndicator;

  //Enable/Disable Image Overlay Shadow. Default false
  final bool overlayShadow;

  //Choose the color of the overlay Shadow color. Default Colors.grey[800]
  final Color overlayShadowColors;

  //Choose the size of the Overlay Shadow, from 0.0 to 1.0. Default 0.5
  final double overlayShadowSize;

  //Enable/Disable the auto play of the slider. Default true
  final bool autoplay;

  //Duration of the Auto play slider by seconds. Default 3 seconds
  final Duration autoplayDuration;

  final bool isDotIndicatorBottom;

  CCMCarousel(
      {this.images,
      this.animationCurve = Curves.ease,
      this.animationDuration = const Duration(milliseconds: 300),
      this.dotSize = 8.0,
      this.dotSpacing = 25.0,
      this.dotIncreaseSize = 2.0,
      this.dotColor = Colors.white,
      this.dotBgColor,
      this.showIndicator = true,
      this.indicatorBgPadding = 20.0,
      this.boxFit = BoxFit.cover,
      this.borderRadius = false,
      this.radius,
      this.moveIndicatorFromBottom = 0.0,
      this.noRadiusForIndicator = false,
      this.overlayShadow = false,
      this.overlayShadowColors,
      this.overlayShadowSize = 0.5,
      this.autoplay = true,
      this.autoplayDuration = const Duration(seconds: 3),
      this.isDotIndicatorBottom})
      : assert(images != null),
        assert(animationCurve != null),
        assert(animationDuration != null),
        assert(dotSize != null),
        assert(dotSpacing != null),
        assert(dotIncreaseSize != null),
        assert(dotColor != null);

  @override
  State createState() => new CCMCarouselState();
}

class CCMCarouselState extends State<CCMCarousel> {
  final _controller = PageController();

  @override
  void initState() {
    super.initState();

    if (widget.autoplay) {
      new Timer.periodic(widget.autoplayDuration, (_) {
        if (_controller.page == widget.images.length - 1) {
          _controller.animateToPage(
            0,
            duration: widget.animationDuration,
            curve: widget.animationCurve,
          );
        } else {
          _controller.nextPage(
              duration: widget.animationDuration, curve: widget.animationCurve);
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listImages = widget.images
        .map((netImage) => Container(
              child: netImage,
              // decoration: new BoxDecoration(
              //     borderRadius: widget.borderRadius
              //         ? new BorderRadius.all(widget.radius != null
              //             ? widget.radius
              //             : new Radius.circular(8.0))
              //         : null,
              //     image: new DecorationImage(
              //       //colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
              //       image: netImage,
              //       fit: widget.boxFit,
              //     )),
              // child: widget.overlayShadow
              //     ? new Container(
              //         decoration: new BoxDecoration(
              //           gradient: new LinearGradient(
              //             begin: Alignment.bottomCenter,
              //             end: Alignment.center,
              //             stops: [0.0, widget.overlayShadowSize],
              //             colors: [
              //               widget.overlayShadowColors != null
              //                   ? widget.overlayShadowColors.withOpacity(1.0)
              //                   : Colors.grey[800].withOpacity(1.0),
              //               widget.overlayShadowColors != null
              //                   ? widget.overlayShadowColors.withOpacity(0.0)
              //                   : Colors.grey[800].withOpacity(0.0)
              //             ],
              //           ),
              //         ),
              //       )
              //     : new Container(),
            ))
        .toList();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: PageView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _controller,
              children: listImages,
            ),
          ),
          // Center(
          //     child: DotsIndicator(
          //   controller: _controller,
          //   itemCount: listImages.length,
          //   color: widget.dotColor,
          //   dotSize: widget.dotSize,
          //   dotSpacing: widget.dotSpacing,
          //   dotIncreaseSize: widget.dotIncreaseSize,
          //   onPageSelected: (int page) {
          //     _controller.animateToPage(
          //       page,
          //       duration: widget.animationDuration,
          //       curve: widget.animationCurve,
          //     );
          //   },
          // )),
          widget.showIndicator
              ? Positioned(
                  bottom: widget.moveIndicatorFromBottom,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.dotBgColor == null
                          ? Colors.grey[800].withOpacity(0.0)
                          : widget.dotBgColor,
                      borderRadius: widget.borderRadius
                          ? (widget.noRadiusForIndicator
                              ? null
                              : BorderRadius.only(
                                  bottomLeft: widget.radius != null
                                      ? widget.radius
                                      : Radius.circular(8.0),
                                  bottomRight: widget.radius != null
                                      ? widget.radius
                                      : Radius.circular(8.0)))
                          : null,
                    ),
                    padding: EdgeInsets.all(widget.indicatorBgPadding),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator(
      {this.controller,
      this.itemCount,
      this.onPageSelected,
      this.color,
      this.dotSize,
      this.dotIncreaseSize,
      this.dotSpacing})
      : super(listenable: controller);

  // The PageController that this DotsIndicator is representing.
  final PageController controller;

  // The number of items managed by the PageController
  final int itemCount;

  // Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  // The color of the dots.
  final Color color;

  // The base size of the dots
  final double dotSize;

  // The increase in the size of the selected dot
  final double dotIncreaseSize;

  // The distance between the center of each dot
  final double dotSpacing;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (dotIncreaseSize - 1.0) * selectedness;
    return new Container(
      width: dotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: dotSize * zoom,
            height: dotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}