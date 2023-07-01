[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/SherlockHolmes2045/flutter_lightbox/blob/master/LICENSE)

A Simple Lightbox Component for Flutter with swiping and thumbnail capabilities.

## Demo
<img src="https://github.com/ThePikachu/flutter_lightbox/assets/27757830/402dcc5d-8e85-4938-a017-3092308bdabe"  height="675">

## Features
* Supports Image.Asset and Image.Network
* Swiping left and right
* Animation for Swiping
* Clickable Thumbnails

## Example Usage
Wrap your images with an InkWell and add this to the onTap function().
```dart
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return LightBox(
          initialIndex: index,
          images: images,
          imageType: imageType,
        );
      },
    );
```
For example of usage, please refer to [example](https://github.com/ThePikachu/flutter_lightbox/blob/main/example/lib/main.dart).

## Customisation
Misc
* blur - background blur
* animationType - Curves ([reference](https://api.flutter.dev/flutter/animation/Curves-class.html))
* animationDuration - how long is the swipe animation

Image
* imageWidth - width of Image
* imageHeight - height of Image
* imageFit - BoxFit of Image

Thumbnail
* thumbnailWidth - width of thumbnail
* thumbnailHeight - height of thumbnail
* thumbnailBorderSize - size of thumbnail border
* thumbNailBorderRadius - border radius of thumbnail
* thumbNailFocusedBorderColor - thumbnail focused border color
* thumbNailUnFocusedBorderColor - thumbnail unfocused border color
* thumbNailUnfocusedOpacity - thumbnail unfocused opacity
* thumbNailGap - EdgeInset - how far apart are each thumbnail from one another
* thumbNailFit - BoxFit of thumbnail
* thumbNailMarginFromBottom - thumbnail margin bottom 


## Installation
Run this command:
```
flutter pub add flutter_lightbox
```

### Import It
Now in your Dart Code, you can use:
```
import 'package:flutter_lightbox/flutter_lightbox.dart';
```


