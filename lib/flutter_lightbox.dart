library flutter_lightbox;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lightbox/image_type.dart';

class LightBox extends StatefulWidget {
  const LightBox({
    super.key,
    required this.images,
    required this.imageType,
    this.initialIndex = 0,
    this.blur = 5,
    this.animationType = Curves.easeInOut,
    this.animationDuration = 200,
    this.imageWidth = 0.6,
    this.imageHeight = 0.6,
    this.imageFit = BoxFit.contain,
    this.thumbnailWidth = 50,
    this.thumbnailHeight = 50,
    this.thumbNailBorderSize = 2,
    this.thumbNailBorderRadius = 5,
    this.thumbNailFocusedBorderColor = Colors.blue,
    this.thumbNailUnfocusedBorderColor = Colors.transparent,
    this.thumbNailUnFocusedOpacity = 0.5,
    this.thumbNailFit = BoxFit.cover,
    this.thumbNailGap = const EdgeInsets.symmetric(horizontal: 5),
    this.thumbNailmarginFromBottom = 30,
  });

  // List of images, currently support from assets and url
  final List<String> images;
  // Type of Image, ImageType.ImageAsset or ImageType.Network
  final ImageType imageType;
  // Starting Image Index of LightBox
  final int initialIndex;
  // Background Blur
  final double blur;
  // Animation Type : Curves (For reference : https://api.flutter.dev/flutter/animation/Curves-class.html)
  final Curve animationType;
  // How long it takes to swipe to next image (in milliseconds)
  // Value lower than 10 will be instant
  final int animationDuration;

  // Image Properties
  final double imageWidth;
  final double imageHeight;
  final BoxFit imageFit;

  // Thumbnail Properties
  final double thumbnailWidth;
  final double thumbnailHeight;
  final double thumbNailBorderSize;
  final double thumbNailBorderRadius;
  final Color thumbNailFocusedBorderColor;
  final Color thumbNailUnfocusedBorderColor;
  final double thumbNailUnFocusedOpacity;
  final EdgeInsets thumbNailGap;
  final BoxFit thumbNailFit;
  final double thumbNailmarginFromBottom;

  @override
  State<LightBox> createState() => _LightBoxState();
}

class _LightBoxState extends State<LightBox> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.images.isNotEmpty) {
      _currentIndex = widget.initialIndex;
    }
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _previousImage() {
    _goToImage(--_currentIndex > -1 ? _currentIndex : widget.images.length - 1);
  }

  void _nextImage() {
    _goToImage(++_currentIndex > widget.images.length - 1 ? 0 : _currentIndex);
  }

  void _goToImage(int index) {
    if (widget.animationDuration >= 10) {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: widget.animationDuration),
        curve: widget.animationType,
      );
    } else {
      _pageController.jumpToPage(index);
    }
  }

  Widget imageWidget(ImageType imageType, String url) {
    if (imageType == ImageType.ImageAsset) {
      return Image.asset(
        url,
      );
    } else if (imageType == ImageType.Network) {
      return Image.network(
        url,
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onHorizontalDragEnd: (DragEndDetails details) {
                        if (details.velocity.pixelsPerSecond.dx > 0) {
                          _previousImage();
                        } else if (details.velocity.pixelsPerSecond.dx < 0) {
                          _nextImage();
                        }
                      },
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.images.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            child: InteractiveViewer(
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    widget.imageWidth,
                                height: MediaQuery.of(context).size.height *
                                    widget.imageHeight,
                                child: FittedBox(
                                  fit: widget.imageFit,
                                  child: imageWidget(
                                      widget.imageType, widget.images[index]),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(widget.images.length, (index) {
                        return Container(
                            width: widget.thumbnailWidth,
                            height: widget.thumbnailHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  widget.thumbNailBorderRadius),
                              border: Border.all(
                                  color: _currentIndex == index
                                      ? widget.thumbNailFocusedBorderColor
                                      : widget.thumbNailUnfocusedBorderColor,
                                  width: widget.thumbNailBorderSize),
                            ),
                            margin: widget.thumbNailGap,
                            child: GestureDetector(
                              onTap: () {
                                _goToImage(index);
                              },
                              child: Opacity(
                                  opacity: _currentIndex == index
                                      ? 1
                                      : widget.thumbNailUnFocusedOpacity,
                                  child: FittedBox(
                                    fit: widget.thumbNailFit,
                                    child: imageWidget(
                                        widget.imageType, widget.images[index]),
                                  )),
                            ));
                      })),
                  SizedBox(height: widget.thumbNailmarginFromBottom)
                ],
              ),
            ),
          ),
        ));
  }
}
